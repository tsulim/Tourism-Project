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
    public class Location
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Details { get; set; }
        public string Type { get; set; }
        public string Images { get; set; }
        public bool Status { get; set; }
        public int UserId { get; set; }

        public Location()
        {
        }

        public Location(string name, string address, string details, string type, string images, int userid)
        {
            Id = 0;
            Name = name;
            Address = address;
            Details = details;
            Type = type;
            Images = images;
            Status = true;
            UserId = userid;
        }

        public Location(int id, string name, string address, string details, string type, string images, bool status, int userid)
        {
            Id = id;
            Name = name;
            Address = address;
            Details = details;
            Type = type;
            Images = images;
            Status = status;
            UserId = userid;
        }
        public int Insert()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO Location (Name, Address, Details, Type, Images, Status, UserId) " +
                "VALUES (@paraName, @paraAddress, @paraDetails, @paraType, @paraImages, @paraStatus, @paraUserId)";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraName", Name);
            sqlCmd.Parameters.AddWithValue("@paraAddress", Address);
            sqlCmd.Parameters.AddWithValue("@paraDetails", Details);
            sqlCmd.Parameters.AddWithValue("@paraType", Type);
            sqlCmd.Parameters.AddWithValue("@paraImages", Images);
            sqlCmd.Parameters.AddWithValue("@paraStatus", Status);
            sqlCmd.Parameters.AddWithValue("@paraUserId", UserId);

            myConn.Open();

            int result = sqlCmd.ExecuteNonQuery();

            myConn.Close();

            return result;
        }
        public List<Location> SelectAll()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from Location";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);

            DataSet ds = new DataSet();

            da.Fill(ds);

            List<Location> locaList = new List<Location>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                int id = Convert.ToInt32(row["Id"]);
                string name = row["Name"].ToString();
                string address = row["Address"].ToString();
                string details = row["Details"].ToString();
                string type = row["Type"].ToString();
                string images = row["Images"].ToString();
                bool status = Convert.ToBoolean(row["Status"]);
                int userId = Convert.ToInt32(row["UserId"]);

                Location loca = new Location(id, name, address, details, type, images, status, userId);
                locaList.Add(loca);
            }
            return locaList;
        }

        public List<Location> SelectAllByUserId(int userId)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from Location where UserId = @paraUserId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraUserId", userId);

            DataSet ds = new DataSet();

            da.Fill(ds);

            List<Location> locaList = new List<Location>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                int id = Convert.ToInt32(row["Id"]);
                string name = row["Name"].ToString();
                string address = row["Address"].ToString();
                string details = row["Details"].ToString();
                string type = row["Type"].ToString();
                string images = row["Images"].ToString();
                bool status = Convert.ToBoolean(row["Status"]);

                Location loca = new Location(id, name, address, details, type, images, status, userId);
                locaList.Add(loca);
            }
            return locaList;
        }

        public List<Location> SelectAllAvail()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from Location where Status = @paraStatus";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraStatus", true);

            DataSet ds = new DataSet();

            da.Fill(ds);

            List<Location> locaList = new List<Location>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                int id = Convert.ToInt32(row["Id"]);
                string name = row["Name"].ToString();
                string address = row["Address"].ToString();
                string details = row["Details"].ToString();
                string type = row["Type"].ToString();
                string images = row["Images"].ToString();
                bool status = Convert.ToBoolean(row["Status"]);
                int userId = Convert.ToInt32(row["UserId"]);

                Location loca = new Location(id, name, address, details, type, images, status, userId);
                locaList.Add(loca);
            }
            return locaList;
        }

        public List<Location> SelectAllType(string type)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from Location where Type = @paraType AND Status = @paraStatus";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraType", type);
            da.SelectCommand.Parameters.AddWithValue("@paraStatus", true);

            DataSet ds = new DataSet();

            da.Fill(ds);

            List<Location> locaList = new List<Location>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                int id = Convert.ToInt32(row["Id"]);
                string name = row["Name"].ToString();
                string address = row["Address"].ToString();
                string details = row["Details"].ToString();
                string images = row["Images"].ToString();
                bool status = Convert.ToBoolean(row["Status"]);
                int userId = Convert.ToInt32(row["UserId"]);

                Location loca = new Location(id, name, address, details, type, images, status, userId);
                locaList.Add(loca);
            }
            return locaList;
        }

        public Location SelectLast(int userId)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from Location where UserId = @paraUserId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraUserId", userId);

            DataSet ds = new DataSet();
            da.Fill(ds);

            Location loca = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt >= 1)
            {
                DataRow row = ds.Tables[0].Rows[rec_cnt-1];  // Retrieve last record
                int id = Convert.ToInt32(row["Id"].ToString());
                string name = row["Name"].ToString();
                string address = row["Address"].ToString();
                string details = row["Details"].ToString();
                string type = row["Type"].ToString();
                string images = row["Images"].ToString();
                bool status = Convert.ToBoolean(row["Status"]);

                loca = new Location(id, name, address, details, type, images, status, userId);
            }
            return loca;
        }

        public Location SelectById(int locaId)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from Location where Id = @paraId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraId", locaId);

            DataSet ds = new DataSet();
            da.Fill(ds);

            Location loca = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt >= 1)
            {
                DataRow row = ds.Tables[0].Rows[rec_cnt - 1];  // Retrieve last record
                string name = row["Name"].ToString();
                string address = row["Address"].ToString();
                string details = row["Details"].ToString();
                string type = row["Type"].ToString();
                string images = row["Images"].ToString();
                bool status = Convert.ToBoolean(row["Status"]);
                int userId = Convert.ToInt32(row["UserId"].ToString());

                loca = new Location(locaId, name, address, details, type, images, status, userId);
            }
            return loca;
        }
    }
}
