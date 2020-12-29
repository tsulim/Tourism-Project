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
        public string ProfImage { get; set; }
        public string Name { get; set; }
        public string PasswordHash { get; set; }
        public string PasswordSalt { get; set; }
        public string Email { get; set; }
        public string Contact { get; set; }
        public int Authorization { get; set; }
        public string StripeId { get; set; }

        public User()
        {
        }

        public User(string id, string profImage, string name, string passwordHash, string passwordSalt, string email, string contact, int authorization, string stripeId)
        {
            Id = id;
            ProfImage = profImage;
            Name = name;
            PasswordHash = passwordHash;
            PasswordSalt = passwordSalt;
            Email = email;
            Contact = contact;
            Authorization = authorization;
            StripeId = stripeId;
            
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
                string profImage = row["ProfImage"].ToString();
                string name = row["Name"].ToString();
                string passwordHash = row["PasswordHash"].ToString();
                string passwordSalt = row["PasswordSalt"].ToString();
                string email = row["Email"].ToString();
                string contact = row["Contact"].ToString();
                int authorization = int.Parse(row["Authorization"].ToString());
                string stripeId = row["StripeId"].ToString();
                user = new User(id, profImage, name, passwordHash, passwordSalt, email, contact, authorization, stripeId);
            }
            return user;
        }
    }
}
