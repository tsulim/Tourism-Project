using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBService.Entity
{
    public class Tasks
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Desc { get; set; }
        public Double Difficulty { get; set; }

        public string TeamId { get; set; }


        public Tasks()
        {

        }

        public Tasks(string name, string desc, Double difficulty, string teamId)
        {
            Name = name;
            Desc = desc;
            Difficulty = difficulty;
            TeamId = teamId;
        }
        public Tasks(string id, string name, string desc, Double difficulty, string teamId)
        {
            Id = id;
            Name = name;
            Desc = desc;
            Difficulty = difficulty;
            TeamId = teamId;
        }

        public int CreateTask()
        {

            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO [EventTask] (Name, Description, Difficulty, TeamId ) " +
                "VALUES (@paraName, @paraDescription, @paraDifficulty, @paraTeamId)";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraName", Name);
            sqlCmd.Parameters.AddWithValue("@paraDescription", Desc);
            sqlCmd.Parameters.AddWithValue("@paraDifficulty", Difficulty);
            sqlCmd.Parameters.AddWithValue("@paraTeamId", TeamId);


            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }

        public int UpdateTask()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "UPDATE [EventTask] SET Name=@paraName, Description=@paraDescription, Difficulty=@paraDifficulty, EventId=@paraEventId " +
                "WHERE Id=@paraId;";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraName", Name);
            sqlCmd.Parameters.AddWithValue("@paraDescription", Desc);
            sqlCmd.Parameters.AddWithValue("@paraDifficulty", Difficulty);
            sqlCmd.Parameters.AddWithValue("@paraTeamId", TeamId);

            sqlCmd.Parameters.AddWithValue("@paraId", Id);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }

        public int DeleteTask(string taskId)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "DELETE FROM [EventTask] WHERE Id=@paraId;";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);
            sqlCmd.Parameters.AddWithValue("@paraId", taskId);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;

        }


        public List<Tasks> SelectAllTasksByEventTeamId(string eventTeamId)
        {

            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from [EventTask] WHERE TeamId=@paraEventTeamId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraEventTeamId", eventTeamId);

            DataSet ds = new DataSet();
            da.Fill(ds);

            List<Tasks> taskList = new List<Tasks>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];

                string idVal = row["Id"].ToString();
                string name = row["Name"].ToString();
                string description = row["Description"].ToString();
                Double difficulty = Double.Parse(row["Difficulty"].ToString());

                Tasks taskObj = new Tasks(idVal, name, description, difficulty, eventTeamId);
                taskList.Add(taskObj);
            }
            return taskList;
        }


    }
}
