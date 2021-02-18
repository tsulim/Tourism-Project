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

using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using Tobloggo.MyDBServiceReference;



using Nemiro.OAuth;
using Nemiro.OAuth.Clients;
using System.Configuration;

using Newtonsoft.Json;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading.Tasks;

namespace Tobloggo
{
    public partial class Login : System.Web.UI.Page {
        protected string googleplus_client_id = ConfigurationManager.AppSettings["google_client_id"];    // Replace this with your Client ID
        protected string googleplus_client_secret = ConfigurationManager.AppSettings["google_client_secret"];                                                // Replace this with your Client Secret
        protected string googleplus_redirect_url = ConfigurationManager.AppSettings["google_redirect_url"];                                         // Replace this with your Redirect URL; Your Redirect URL from your developer.google application should match this URL.
        protected string Parameters;

        protected void Page_Load(object sender, EventArgs e)
        {

            if ((Session.Contents.Count > 0) && (Session["loginWith"] != null) && (Session["loginWith"].ToString() == "google"))
            {
                try
                {
                    var url = Request.Url.Query;
                    if (url != "")
                    {
                        string queryString = url.ToString();
                        char[] delimiterChars = { '=' };
                        string[] words = queryString.Split(delimiterChars);
                        string code = words[1];

                        if (code != null)
                        {
                            //get the access token 
                            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create("https://accounts.google.com/o/oauth2/token");
                            webRequest.Method = "POST";
                            Parameters = "code=" + code + "&client_id=" + googleplus_client_id + "&client_secret=" + googleplus_client_secret + "&redirect_uri=" + googleplus_redirect_url + "&grant_type=authorization_code";
                            byte[] byteArray = Encoding.UTF8.GetBytes(Parameters);
                            webRequest.ContentType = "application/x-www-form-urlencoded";
                            webRequest.ContentLength = byteArray.Length;
                            Stream postStream = webRequest.GetRequestStream();
                            // Add the post data to the web request
                            postStream.Write(byteArray, 0, byteArray.Length);
                            postStream.Close();

                            WebResponse response = webRequest.GetResponse();
                            postStream = response.GetResponseStream();
                            StreamReader reader = new StreamReader(postStream);
                            string responseFromServer = reader.ReadToEnd();

                            GooglePlusAccessToken serStatus = JsonConvert.DeserializeObject<GooglePlusAccessToken>(responseFromServer);

                            if (serStatus != null)
                            {
                                Session.Remove("loginWith");
                                string accessToken = string.Empty;
                                accessToken = serStatus.access_token;

                                System.Diagnostics.Debug.WriteLine("SomeText");
                                if (!string.IsNullOrEmpty(accessToken))
                                {
                                    GoogleUserOutputData userData = getgoogleplususerdataSer(accessToken).Result;
                                    //Create new google account
                                    MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                                    client.CreateOrFindSingleGoogleUser(userData.id, userData.name, userData.email);

                                    Session["UserID"] = userData.email;

                                    //Create a new GUID and save into the session
                                    string guid = Guid.NewGuid().ToString();
                                    Session["AuthToken"] = guid;
                                    Response.Cookies.Add(new HttpCookie("AuthToken", guid));

                                    //Go back to home page
                                    Response.Redirect("Default.aspx", false);

                                }
                            }

                        }
                    }
                }
                catch (Exception ex)
                {
                    //throw new Exception(ex.Message, ex);
                    //Response.Redirect("Default.aspx");
                }
            }
        }


        protected void Google_Click(object sender, EventArgs e)
        {
            var Googleurl = "https://accounts.google.com/o/oauth2/auth?response_type=code&redirect_uri=" + googleplus_redirect_url + "&scope=https://www.googleapis.com/auth/userinfo.email%20https://www.googleapis.com/auth/userinfo.profile&client_id=" + googleplus_client_id+ "&prompt=select_account";
            Session["loginWith"] = "google";
            Response.Redirect(Googleurl);
        }

        public class GooglePlusAccessToken
        {
            public string access_token { get; set; }
            public string token_type { get; set; }
            public int expires_in { get; set; }
            public string id_token { get; set; }
            public string refresh_token { get; set; }
        }
        private async Task<GoogleUserOutputData> getgoogleplususerdataSer(string access_token)
        {
            try
            {
                HttpClient client = new HttpClient();
                var urlProfile = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + access_token;

                client.CancelPendingRequests();
                System.Diagnostics.Debug.WriteLine(access_token);
                HttpResponseMessage output = client.GetAsync(urlProfile).Result;

                if (output.IsSuccessStatusCode)
                {
                    string outputData = await output.Content.ReadAsStringAsync();
                    GoogleUserOutputData serStatus = JsonConvert.DeserializeObject<GoogleUserOutputData>(outputData);

                    if (serStatus != null)
                    {
                        return serStatus;
                    }
                }
                return new GoogleUserOutputData();
            }
            catch (Exception ex)
            {
                //catching the exception
                return new GoogleUserOutputData();
            }
        }

        public class GoogleUserOutputData
        {
            public string id { get; set; }
            public string name { get; set; }
            public string given_name { get; set; }
            public string email { get; set; }
            public string picture { get; set; }
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


        protected void btn_submit_Click(object sender, EventArgs e)
        {
            lbl_errormsg.Text = "Testing";
            if (ValidateCaptcha())
            {
                string email = tb_email.Text.ToString().Trim();
                string pwd = tb_password.Text.ToString().Trim();
                SHA512Managed hashing = new SHA512Managed();


                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                User user = client.GetUserByEmail(tb_email.Text);

                string dbHash = user.PasswordHash;
                string dbSalt = user.PasswordSalt;

                try
                {
                    if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0)
                    {
                        string pwdWithSalt = pwd + dbSalt;
                        byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                        string userHash = Convert.ToBase64String(hashWithSalt);
                        if (userHash.Equals(dbHash))
                        {
                            Session["UserID"] = email;
                            //Create a new GUID and save into the session
                            string guid = Guid.NewGuid().ToString();
                            Session["AuthToken"] = guid;
                            Response.Cookies.Add(new HttpCookie("AuthToken", guid));

                            //client.UpdateUser(user);

                            //List<User> name = client.GetAllUsers().ToList();

                            Response.Redirect("Default.aspx", false);
                        }
                        else
                        {
                            lbl_errormsg.Text = "Email or password is not valid. Please try again.";
                        }
                    }
                    else
                    {
                        lbl_errormsg.Text = "Email or password is not valid. Please try again.";
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
                finally { }
            }
            else
            {
                lbl_errormsg.Text = "Hi robot! :D";
            }
        
    }


        public class GoogleToken
        {
            public string access_token { get; set; }
            public string token_type { get; set; }
            public int expires_in { get; set; }
            public string id_token { get; set; }
            public string refresh_token { get; set; }
        }
        public class GoogleInfo
        {
            public string id { get; set; }
            public string email { get; set; }
            public bool verified_email { get; set; }
            public string name { get; set; }
            public string given_name { get; set; }
            public string family_name { get; set; }
            public string picture { get; set; }
            public string locale { get; set; }
            public string gender { get; set; }
        }
    }
}