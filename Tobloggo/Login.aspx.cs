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


using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

using Google.Apis.Auth.OAuth2;
using Google.Apis.Books.v1;
using Google.Apis.Books.v1.Data;
using Google.Apis.Services;
using Google.Apis.Util.Store;

using Nemiro.OAuth;
using Nemiro.OAuth.Clients;
using System.Configuration;

namespace Tobloggo
{
    public partial class Login : System.Web.UI.Page
    {
        protected void RedirectToLogin_Click(object sender, EventArgs e)
        {
            // gets a provider name from the data-provider
            string provider = ((LinkButton)sender).Attributes["data-provider"];
            // build the return address
            string returnUrl = new Uri(Request.Url, "ExternalLoginResult.aspx").AbsoluteUri;
            // redirect user into external site for authorization
            OAuthWeb.RedirectToAuthorization(provider, returnUrl);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginWith"] != null)
            {
                FetchUserSocialDetail("google");
            }

           
        }

        protected void GoogleBtnClick(object sender, EventArgs e)
        {
            GetSocialCredentials("google");
        }
        private void GetSocialCredentials(String provider)
        {
            if (provider == "google")
            {
                string Googleurl = String.Format(ConfigurationManager.AppSettings["Googleurl"], ConfigurationManager.AppSettings["google_redirect_url"], ConfigurationManager.AppSettings["google_client_id"]);
                Session["LoginWith"] = provider;
                Response.Redirect(Googleurl);
            }
        }

        private void FetchUserSocialDetail(String provider)
        {
            try
            {
                var url = Request.Url.Query;
                if (!string.IsNullOrEmpty(url))
                {
                    string code = Request.QueryString["code"];
                    if (!string.IsNullOrEmpty(code))
                    {
                        string Parameters = "code=" + code + "&client_id=" + ConfigurationManager.AppSettings["google_client_id"] +
                        "&client_secret=" + ConfigurationManager.AppSettings["google_client_secret"] + "&redirect_uri=" + ConfigurationManager.AppSettings
                        ["google_redirect_url"] + "&grant_type=authorization_code";
                        string parameters = string.Format("code={0}&client_id={1}&client_secret={2}&redirect_uri={3}& grant_type = authorization_code",
                            code,
                            ConfigurationManager.AppSettings["google_client_id"],
                            ConfigurationManager.AppSettings["google_client_secret"],
                            ConfigurationManager.AppSettings["google_redirect_url"]);
                        string response = MakeWebRequest(ConfigurationManager.AppSettings["googleoAuthUrl"], "POST", "application/x-www-form - urlencoded", parameters);

                        GoogleToken tokenInfo = new JavaScriptSerializer().Deserialize<GoogleToken>(response);

                        if (tokenInfo != null)
                        {
                            if (!string.IsNullOrEmpty(tokenInfo.access_token))
                            {
                                var googleInfo = MakeWebRequest(ConfigurationManager.AppSettings["googleoAccessUrl"] + tokenInfo.access_token, "GET");
                                GoogleInfo profile = new JavaScriptSerializer().Deserialize<GoogleInfo>(googleInfo);
                                txtResponse.Text = googleInfo;
                            }
                        }
                    }
                }
                Session.Remove("LoginWith");
            }
            catch (Exception ex)
            {
                Response.Redirect("error.aspx");
            }
        }

        /// <summary>
        /// Calling 3rd party web apis.
        /// </summary>
        /// <param name="destinationUrl"></param>
        /// <param name="methodName"></param>
        /// <param name="requestJSON"></param>
        /// <returns></returns>
        public string MakeWebRequest(string destinationUrl, string methodName, string contentType = "", string requestJSON = "")
        {
            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(destinationUrl);
                request.Method = methodName;
                if (methodName == "POST")
                {
                    byte[] bytes = System.Text.Encoding.ASCII.GetBytes(requestJSON);
                    request.ContentType = contentType;
                    request.ContentLength = bytes.Length;
                    using (Stream requestStream = request.GetRequestStream())
                    {
                        requestStream.Write(bytes, 0, bytes.Length);
                    }
                }
                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                {
                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                        {
                            return reader.ReadToEnd();
                        }
                    }
                }

                return null;
            }
            catch (WebException webEx)
            {
                return webEx.Message;
            }
        }

        //-----
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
                int attempts = user.LockoutCount;

                if (attempts >= 3)
                {
                    lbl_errormsg.Text = "Your account has been locked out.";
                }
                else
                {
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

                                user.LockoutCount = 0;
                                client.UpdateUser(user);

                                Response.Redirect("Default.aspx", false);
                            }
                            else
                            {
                                user.LockoutCount = user.LockoutCount + 1;

                                int remainingAttempts = 2 - attempts;
                                if (remainingAttempts <= 0)
                                {
                                    lbl_errormsg.Text = "Account has been locked out!";
                                }
                                else if (remainingAttempts == 1)
                                {
                                    lbl_errormsg.Text = "Email or password is not valid. Please try again. 1 more attempt before account lockout";
                                }
                                else
                                {
                                    lbl_errormsg.Text = "Email or password is not valid. Please try again.";
                                }
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
        public class FacebookInfo
        {
            public string first_name { get; set; }
            public string last_name { get; set; }
            public string gender { get; set; }
            public string locale { get; set; }
            public string link { get; set; }
            public string id { get; set; }
            public string email { get; set; }
        }

        public class FacebookToken
        {
            public string access_token { get; set; }
            public string token_type { get; set; }
            public int expires_in { get; set; }
        }

    }
}