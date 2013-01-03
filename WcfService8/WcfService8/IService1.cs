using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfService8
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IService1
    {


        [OperationContract]


        [WebGet(UriTemplate = "/GetUserDetails",
RequestFormat = WebMessageFormat.Xml,
ResponseFormat = WebMessageFormat.Xml,
BodyStyle = WebMessageBodyStyle.Bare)]

        List<UserDetails> GetUserDetails();
        //List<UserDetails> GetUserDetails(string Username);



        [OperationContract]
        [WebInvoke(UriTemplate = "/InsertUserDetails?userInfo", Method = "POST", RequestFormat = WebMessageFormat.Json,

            ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Wrapped)]
        string InsertUserDetails(UserDetails userInfo);

                 

        //testing

        [OperationContract]
        [WebInvoke(Method = "GET",
            RequestFormat = WebMessageFormat.Xml,
            ResponseFormat = WebMessageFormat.Xml,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "/ins/{Name}/{FName}/{LName}/{Location}")]
        string datainst(string Name, string FName, string LName, string Location);
                
        //
                     

        //[OperationContract]
        //string InsertUserDetails(UserDetails userInfo);


        [OperationContract]
        [WebInvoke(Method = "GET",
            RequestFormat = WebMessageFormat.Xml,
            ResponseFormat = WebMessageFormat.Xml,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "/xml/{id}")]        
        string XMLDATA(string id);
                            

        [OperationContract]
        [WebInvoke(Method = "GET",
            ResponseFormat = WebMessageFormat.Json,
            BodyStyle = WebMessageBodyStyle.Wrapped,
            UriTemplate = "json/{id}")]        
        string JSONDATA(string id);

        [OperationContract]
        [WebGet(UriTemplate = "/GetPlayersXml",
RequestFormat = WebMessageFormat.Xml,
ResponseFormat = WebMessageFormat.Xml,
BodyStyle = WebMessageBodyStyle.Bare)]
        List<Players> GetPlayersXml();



        [OperationContract]
        [WebGet(UriTemplate = "/GetPlayersJson",
RequestFormat = WebMessageFormat.Json,
ResponseFormat = WebMessageFormat.Json,
BodyStyle = WebMessageBodyStyle.Bare)]
        List<Players> GetPlayersJson();

    }


    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    [DataContract]
    public class UserDetails
    {
        string username = string.Empty;
        string firstname = string.Empty;
        string lastname = string.Empty;
        string location = string.Empty;

        [DataMember]
        public string UserName
        {
            get { return username; }
            set { username = value; }
        }
        [DataMember]
        public string FirstName
        {
            get { return firstname; }
            set { firstname = value; }
        }
        [DataMember]
        public string LastName
        {
            get { return lastname; }
            set { lastname = value; }
        }
        [DataMember]
        public string Location
        {
            get { return location; }
            set { location = value; }
        }
    }

    [DataContract]
    public class Players
    {
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Sports { get; set; }
        [DataMember]
        public string Country { get; set; }
        [DataMember]
        public string ImageUrl { get; set; }

    }

}
