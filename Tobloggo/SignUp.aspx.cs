using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Globalization;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo
{
    public partial class SignUp : System.Web.UI.Page
    {
        string finalHash;
        string salt;
        byte[] IV;
        byte[] Key;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            if (ValidateCaptcha() && checkInputs())
            {
                //Generate random "salt"
                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                byte[] saltByte = new byte[8];

                //Fills array of bytes with a cryptographically strong sequence of random values.
                rng.GetBytes(saltByte);
                salt = Convert.ToBase64String(saltByte);  //Salt value to be stored

                SHA512Managed hashing = new SHA512Managed();

                string pwdWithSalt = tb_password.Text + salt;
                byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                finalHash = Convert.ToBase64String(hashWithSalt); //Hash with salt value to be stored

                RijndaelManaged cipher = new RijndaelManaged();
                cipher.GenerateKey();
                Key = cipher.Key;
                IV = cipher.IV;

                createAccount();

                Response.Redirect("Login.aspx", false);
            }
        }

        protected Boolean checkInputs()
        {
            Boolean valid = true;
            List<string> errorList = new List<string>();
                
            if (tb_accname.Text.Length < 1)
            {
                valid = false;
                lbl_accnamechecker.Text = "First name has no value!";
                errorList.Add("• First name no value!");
            }
            else { lbl_accnamechecker.Text = ""; }

            if (!Regex.IsMatch(tb_email.Text, @"^\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$", RegexOptions.IgnoreCase))
            {
                valid = false;
                lbl_emailchecker.Text = "Email has an invalid value!";
                errorList.Add("• Email value is invalid!");
            }
            else
            {

                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                User user = client.GetUserByEmail(tb_email.Text);

                if (user != null)
                {
                    valid = false;
                    lbl_emailchecker.Text = "Email is already a registered account!";
                    errorList.Add("• Email value is already registered!");
                }
                else { lbl_emailchecker.Text = ""; }

            }

            if (!Regex.IsMatch(tb_password.Text, @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@!%*?&]{8,}$"))
            {
                valid = false;
                lbl_pwdchecker.Text = "Invalid Password Input!";
                errorList.Add("• Password value is invalid!");
            }
            else { lbl_pwdchecker.Text = ""; }


            if (tb_contactnum.Text.Length < 1)
            {
                valid = false;
                lbl_contactchecker.Text = "Contact Number has no value!";
                errorList.Add("• Contact Number no value!");
            }


            string errorText = "Error List: \n" + String.Join("\n", errorList);
            lbl_submitchecker.Text = errorText;

            return valid;
        }

        public void createAccount()
        {

            try
            {

                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                int cnt = client.CreateUser(
                    tb_accname.Text.Trim(),
                    finalHash,
                    salt,
                    tb_email.Text.Trim(),
                    tb_contactnum.Text.Trim(),
                    Convert.ToBase64String(IV),
                    Convert.ToBase64String(Key));

                if (cnt == 1)
                {
                    
                }
                else
                {
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            
        }

        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;

                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }

        public class MyObject
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }
        }

        public bool ValidateCaptcha()
        {
            bool result = true;

            //When user submits the recaptcha form, the user gets a response POST parameter.
            //captchaResponse consist of the user click pattern. Behaviour analytics! AI :)
            string captchaResponse = Request.Form["g-recaptcha-response"];

            //To send a GET request to Goole along with the response and Secret key.
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
                ("https://www.google.com/recaptcha/api/siteverify?secret=6LfNt-sZAAAAADGCq7E_k-N3geEpLuUG3znCzege &response=" + captchaResponse);

            try
            {
                //Codes to receive the Response in JSON format from Google Server
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        //The response in JSON format
                        string jsonResponse = readStream.ReadToEnd();

                        //To show the JSON response string for learning purpose (Tested, kept getting 0.9)
                        //lbl_gScore.Text = jsonResponse.ToString();

                        JavaScriptSerializer js = new JavaScriptSerializer();

                        //Create jsonObject to handle the response e.g success or Error
                        //Deserialize Json
                        MyObject jsonObject = js.Deserialize<MyObject>(jsonResponse);

                        //Convert the string "False" to bool false or "True" to bool true
                        result = Convert.ToBoolean(jsonObject.success);
                    }
                }

                return result;
            }
            catch (WebException ex)
            {
                throw ex;
            }
        }
    }
}