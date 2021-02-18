using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DBService.Entity
{
    public class User
    {
        public string Id { get; set; }
        public string GoogleId { get; set; }
        public string ProfImage { get; set; }
        public string Name { get; set; }
        public string PasswordHash { get; set; }
        public string PasswordSalt { get; set; }
        public string Email { get; set; }
        public string Contact { get; set; }
        public int Authorization { get; set; }
        public string StripeId { get; set; }
        public string IV { get; set; }
        public string Key { get; set; }

        public User()
        {
        }

        public User(string name, string passwordHash, string passwordSalt, string email, string contact, string iv, string key)
        {
            Id = "0";
            GoogleId = null;
            ProfImage = null;
            Name = name;
            PasswordHash = passwordHash;
            PasswordSalt = passwordSalt;
            Email = email;
            Contact = contact;
            Authorization = 0;
            StripeId = null;
            IV = iv;
            Key = key;

        }
        public User(string googleId, string name, string email)
        {
            Id = "0";
            GoogleId = googleId;
            ProfImage = null;
            Name = name;
            PasswordHash = null;
            PasswordSalt = null;
            Email = email;
            Contact = null;
            Authorization = 0;
            StripeId = null;
            IV = null;
            Key = null;

        }
        public User(string id, string googleId, string profImage, string name, string passwordHash, string passwordSalt, string email, string contact, int authorization, string stripeId, string iv, string key)
        {
            Id = id;
            GoogleId = googleId;
            ProfImage = profImage;
            Name = name;
            PasswordHash = passwordHash;
            PasswordSalt = passwordSalt;
            Email = email;
            Contact = contact;
            Authorization = authorization;
            StripeId = stripeId;
            IV = iv;
            Key = key;

        }

        public int CreateUser()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO [User] (GoogleId, ProfImage, Name, PasswordHash, PasswordSalt, Email, Contact, [Authorization], StripeId, IV, [Key]) " +
                "VALUES (@paraGoogleId, @paraProfImage, @paraName, @paraPasswordHash, @paraPasswordSalt, @paraEmail, @paraContact, @paraAuthorization, @paraStripeId, @paraIV, @paraKey)";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraGoogleId", String.Empty);
            sqlCmd.Parameters.AddWithValue("@paraProfImage", String.Empty);
            sqlCmd.Parameters.AddWithValue("@paraName", Name);
            sqlCmd.Parameters.AddWithValue("@paraPasswordHash", PasswordHash);
            sqlCmd.Parameters.AddWithValue("@paraPasswordSalt", PasswordSalt);
            sqlCmd.Parameters.AddWithValue("@paraEmail", Email);
            sqlCmd.Parameters.AddWithValue("@paraContact", Contact);
            sqlCmd.Parameters.AddWithValue("@paraAuthorization", Authorization);
            sqlCmd.Parameters.AddWithValue("@paraStripeId", String.Empty);
            sqlCmd.Parameters.AddWithValue("@paraIV", IV);
            sqlCmd.Parameters.AddWithValue("@paraKey", Key);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }

        public int CreateGoogleUser()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO [User] (GoogleId, ProfImage, Name, PasswordHash, PasswordSalt, Email, Contact, [Authorization], StripeId, IV, [Key]) " +
                "VALUES (@paraGoogleId, @paraProfImage, @paraName, @paraPasswordHash, @paraPasswordSalt, @paraEmail, @paraContact, @paraAuthorization, @paraStripeId, @paraIV, @paraKey)";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraGoogleId", GoogleId);
            sqlCmd.Parameters.AddWithValue("@paraProfImage", String.Empty);
            sqlCmd.Parameters.AddWithValue("@paraName", Name);
            sqlCmd.Parameters.AddWithValue("@paraPasswordHash", String.Empty);
            sqlCmd.Parameters.AddWithValue("@paraPasswordSalt", String.Empty);
            sqlCmd.Parameters.AddWithValue("@paraEmail", Email);
            sqlCmd.Parameters.AddWithValue("@paraContact", String.Empty);
            sqlCmd.Parameters.AddWithValue("@paraAuthorization", Authorization);
            sqlCmd.Parameters.AddWithValue("@paraStripeId", String.Empty);
            sqlCmd.Parameters.AddWithValue("@paraIV", String.Empty);
            sqlCmd.Parameters.AddWithValue("@paraKey", String.Empty);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }
        public int UpdateUser()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "UPDATE [User] SET GoogleId=@paraGoogleId, ProfImage=@paraProfImage, Name=@paraName, PasswordHash=@paraPasswordHash, PasswordSalt=@paraPasswordSalt," +
                "Contact=@paraContact, [Authorization]=@paraAuthorization, StripeId=@paraStripeId, IV=@paraIV, [Key]=@paraKey " +
                "WHERE LOWER(Email)=LOWER(@paraEmail);";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraGoogleId", GoogleId);
            sqlCmd.Parameters.AddWithValue("@paraProfImage", ProfImage);
            sqlCmd.Parameters.AddWithValue("@paraName", Name);
            sqlCmd.Parameters.AddWithValue("@paraPasswordHash", PasswordHash);
            sqlCmd.Parameters.AddWithValue("@paraPasswordSalt", PasswordSalt);
            sqlCmd.Parameters.AddWithValue("@paraContact", Contact);
            sqlCmd.Parameters.AddWithValue("@paraAuthorization", Authorization);
            sqlCmd.Parameters.AddWithValue("@paraStripeId", StripeId);
            sqlCmd.Parameters.AddWithValue("@paraIV", IV);
            sqlCmd.Parameters.AddWithValue("@paraKey", Key);

            sqlCmd.Parameters.AddWithValue("@paraEmail", Email);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }
        public User SelectById(string id)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from [User] where Id = @paraId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraId", id);

            DataSet ds = new DataSet();
            da.Fill(ds);

            User user = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];  // Sql command returns only one record
                //string idVal = row["Id"].ToString();
                string googleId = row["GoogleId"].ToString();
                string profImage = row["ProfImage"].ToString();
                string name = row["Name"].ToString();
                string passwordHash = row["PasswordHash"].ToString();
                string passwordSalt = row["PasswordSalt"].ToString();
                string email = row["Email"].ToString();
                string contact = row["Contact"].ToString();
                int authorization = int.Parse(row["Authorization"].ToString());
                string stripeId = row["StripeId"].ToString();
                string iv = row["IV"].ToString();
                string key = row["Key"].ToString();


                user = new User(id, googleId, profImage, name, passwordHash, passwordSalt, email, contact, authorization, stripeId, iv, key);
            }
            return user;
        }

        public User SelectByEmail(string email)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from [User] where LOWER(Email) = LOWER(@paraEmail)";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraEmail", email);

            DataSet ds = new DataSet();
            da.Fill(ds);

            User user = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];  // Sql command returns only one record
                string id = row["Id"].ToString();
                string googleId = row["GoogleId"].ToString();
                string profImage = row["ProfImage"].ToString();
                string name = row["Name"].ToString();
                string passwordHash = row["PasswordHash"].ToString();
                string passwordSalt = row["PasswordSalt"].ToString();
                string emailVal = row["Email"].ToString();
                string contact = row["Contact"].ToString();
                int authorization = int.Parse(row["Authorization"].ToString());
                string stripeId = row["StripeId"].ToString();
                string iv = row["IV"].ToString();
                string key = row["Key"].ToString();


                user = new User(id, googleId, profImage, name, passwordHash, passwordSalt, emailVal, contact, authorization, stripeId, iv, key);
            }
            return user;
        }


        public List<User> SelectAll()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from [User]";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);

            DataSet ds = new DataSet();
            da.Fill(ds);

            List<User> userList = new List<User>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];  // Sql command returns only one record

                string id = row["Id"].ToString();
                string googleId = row["GoogleId"].ToString();
                string profImage = row["ProfImage"].ToString();
                string name = row["Name"].ToString();
                string passwordHash = row["PasswordHash"].ToString();
                string passwordSalt = row["PasswordSalt"].ToString();
                string email = row["Email"].ToString();
                string contact = row["Contact"].ToString();
                int authorization = int.Parse(row["Authorization"].ToString());
                string stripeId = row["StripeId"].ToString();
                string iv = row["IV"].ToString();
                string key = row["Key"].ToString();


                User user = new User(id, googleId, profImage, name, passwordHash, passwordSalt, email, contact, authorization, stripeId, iv, key);
                userList.Add(user);
            }
            return userList;
        }

    }
}
