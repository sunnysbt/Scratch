using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Services;
using System.Net.Mail;
using System.ServiceModel.Activation;


namespace WcfService8
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    public class Service1 : IService1
    {


        private string strConnection = ConfigurationManager.ConnectionStrings["dbconnection"].ToString();



        //public List<UserDetails> GetUserDetails(string Username)
            public List<UserDetails> GetUserDetails()
        {
            List<UserDetails> userdetails = new List<UserDetails>();
            using (SqlConnection con = new SqlConnection(strConnection))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from UserInformation", con);
                //SqlCommand cmd = new SqlCommand("select * from UserInformation where UserName Like '%'+@Name+'%'", con);
                //cmd.Parameters.AddWithValue("@Name", Username);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dtresult = new DataTable();
                da.Fill(dtresult);
                if (dtresult.Rows.Count > 0)
                {
                    for (int i = 0; i < dtresult.Rows.Count; i++)
                    {
                        UserDetails userInfo = new UserDetails();
                        userInfo.UserName = dtresult.Rows[i]["UserName"].ToString();
                        userInfo.FirstName = dtresult.Rows[i]["FirstName"].ToString();
                        userInfo.LastName = dtresult.Rows[i]["LastName"].ToString();
                        userInfo.Location = dtresult.Rows[i]["Location"].ToString();
                        userdetails.Add(userInfo);
                    }
                }
                con.Close();
            }
            return userdetails;
        }
        public string InsertUserDetails(UserDetails userInfo)
        {
            string strMessage = string.Empty;
            using (SqlConnection con = new SqlConnection(strConnection))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("insert into UserInformation(UserName,FirstName,LastName,Location) values(@Name,@FName,@LName,@Location)", con);
                cmd.Parameters.AddWithValue("@Name", userInfo.UserName);
                cmd.Parameters.AddWithValue("@FName", userInfo.FirstName);
                cmd.Parameters.AddWithValue("@LName", userInfo.LastName);
                cmd.Parameters.AddWithValue("@Location", userInfo.Location);
                int result = cmd.ExecuteNonQuery();
                if (result == 1)
                {
                    strMessage = userInfo.UserName + " Details inserted successfully";
                }
                else
                {
                    strMessage = userInfo.UserName + " Details not inserted successfully";
                }
                con.Close();
            }
            return strMessage;
        }


        //datainst
        public string datainst(string Name, string FName, string LName, string Location)
        {
            string strMessage = string.Empty;
            using (SqlConnection con = new SqlConnection(strConnection))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("insert into UserInformation(UserName,FirstName,LastName,Location) values(@Name,@FName,@LName,@Location)", con);
                cmd.Parameters.AddWithValue("@Name", Name);
                cmd.Parameters.AddWithValue("@FName", FName);
                cmd.Parameters.AddWithValue("@LName", LName);
                cmd.Parameters.AddWithValue("@Location", Location);
                int result = cmd.ExecuteNonQuery();
                if (result == 1)
                {
                    strMessage = Name + " Details inserted successfully";
                }
                else
                {
                    strMessage = Name + " Details not inserted successfully";
                }
                con.Close();
            }
            return strMessage;
        }


        public string XMLDATA(string id)
        {
            return "your xml id " + id;
        }
        public string JSONDATA(string id)
        {
            return "your jason id " + id;
        }
        public List<Players> GetPlayersXml()
        {
            return GetPlayers();
        }
        public List<Players> GetPlayersJson()
        {
            return GetPlayers();
        }

        private List<Players> GetPlayers()
        {
            List<Players> Players = new List<Players>
{
new Players
{
Country ="India", Name="Sachin Tendulkar",Sports ="Cricket", ImageUrl="sachin.jpg"
},
new Players
{
Country ="India", Name="MS Dhoni",Sports ="Cricket", ImageUrl="dhoni.jpg"
},
new Players
{
Country ="Australia", Name="Rickey Ponting",Sports ="Cricket", ImageUrl="rickey.jpg"
},
new Players
{
Country ="India", Name="Sandeep Singh",Sports ="Hockey", ImageUrl="sandeep.jpg"
},
 
};
            return Players;
        }
    }



}
