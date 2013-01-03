using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Collectibles : System.Web.UI.Page
{
    Admin admin = new Admin();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["username"] != null)
        {

            if (!IsPostBack)
            {

                bindThemes();
                BindCollectibles();
                if (!string.IsNullOrEmpty(Request.QueryString["CID"]))
                {
                    DataTable dtTicketId = admin.getCollectiblebyColId(Request.QueryString["CID"]);
                    ddlThemes.SelectedValue = dtTicketId.Rows[0]["ThemeId"].ToString();
                    rdopurchase.SelectedValue = dtTicketId.Rows[0]["IsPurchased"].ToString();
                    txtImagename1.Text = dtTicketId.Rows[0]["Imagename1"].ToString();
                    txtImagename2.Text = dtTicketId.Rows[0]["Imagename2"].ToString();
                    txtName.Text = dtTicketId.Rows[0]["colName"].ToString();
                    txtPrice.Text = dtTicketId.Rows[0]["Price"].ToString();
                    btnSubmit.Text = "Update";
                }
                else
                {

                }
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["CID"]))
        {
            if (admin.UpdateCollectiblesData(Request.QueryString["CID"], ddlThemes.SelectedValue, txtName.Text, txtImagename1.Text, txtImagename2.Text, rdopurchase.SelectedValue, txtPrice.Text) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "update", "alert('Successfully Updated.');window.location='Collectibles.aspx';", true);
                ClearAllControl();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "update", "alert('Problem to Update the data.');window.location='Collectibles.aspx';", true);
            }
        }
        else
        {
            if (admin.InsertCollectiblesData(ddlThemes.SelectedValue, txtName.Text, txtImagename1.Text, txtImagename2.Text, rdopurchase.SelectedValue, txtPrice.Text) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "insert", "alert('Successfully Saved.');", true);
                ClearAllControl();
                BindCollectibles();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "insert", "alert('Problem to save the data.');", true);
            }
        }

    }
    public void ClearAllControl()
    {

        ddlThemes.SelectedValue = "-1";
        txtImagename1.Text = "";
        txtImagename2.Text = "";
        txtName.Text = "";
        txtPrice.Text = "";

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {

        ddlThemes.SelectedValue = "-1";
        txtImagename1.Text = "";
        txtImagename2.Text = "";
        txtName.Text = "";
        txtPrice.Text = "";
    }

    protected void bindThemes()
    {
        ddlThemes.DataSource = admin.getThemes();
        ddlThemes.DataTextField = "ThemeName";
        ddlThemes.DataValueField = "Id";
        ddlThemes.DataBind();
        ddlThemes.Items.Insert(0, new ListItem("Select Theme", "-1"));
    }

    protected void grdTicket_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btnEdit")
        {
            Response.Redirect("Collectibles.aspx?CID=" + Convert.ToInt32(e.CommandArgument) + "");
        }
        else if (e.CommandName == "btnActive")
        {
            admin.ActivateCollectiblesStatus(Convert.ToString(e.CommandArgument));
        }
        else if (e.CommandName == "btnDelete")
        {
            admin.DeleteCollectiblesStatus(Convert.ToString(e.CommandArgument));
        }
        BindCollectibles();
    }
    private void BindCollectibles()
    {
        DataTable dtTicket = admin.FillCollectiblesGrid();
        if (dtTicket.Rows.Count > 0)
        {
            grdTickets.DataSource = dtTicket;
            grdTickets.DataBind();
        }
        else
        {
            grdTickets.DataSource = null;
            grdTickets.DataBind();
        }
    }
    protected void pageindexchange(object sender, GridViewPageEventArgs e)
    {
        grdTickets.PageIndex = e.NewPageIndex;
        BindCollectibles();
    }
}