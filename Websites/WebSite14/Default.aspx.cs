using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServiceReference1;

public partial class _Default : System.Web.UI.Page
{
    ServiceReference1.Service1Client objService = new Service1Client();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindUserDetails();
        }
    }
    protected void BindUserDetails()
    {
        IList<UserDetails> objUserDetails = new List<UserDetails>();
        objUserDetails = objService.GetUserDetails();
        gvDetails.DataSource = objUserDetails;
        gvDetails.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        UserDetails userInfo = new UserDetails();
        userInfo.UserName = txtUserName.Text;
        userInfo.FirstName = txtfname.Text;
        userInfo.LastName = txtlname.Text;
        userInfo.Location = txtlocation.Text;
        string result = objService.InsertUserDetails(userInfo);
        lblResult.Text = result;
        BindUserDetails();
        txtUserName.Text = string.Empty;
        txtfname.Text = string.Empty;
        txtlname.Text = string.Empty;
        txtlocation.Text = string.Empty;
    }
}
