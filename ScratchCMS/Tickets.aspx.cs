using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Tickets : System.Web.UI.Page
{
    Admin admin = new Admin();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["username"] != null)
        {

            if (!IsPostBack)
            {
                BindLevels();
                BindTicketType();
                BindTickets();
                if (!string.IsNullOrEmpty(Request.QueryString["TID"]))
                {
                  
                    DataTable dtTicketId = admin.getTicketbyLevelId(Request.QueryString["TID"]);
                    ddlType.SelectedValue = dtTicketId.Rows[0]["TicketTypeId"].ToString();
                    ddlLevel.SelectedValue = dtTicketId.Rows[0]["LevelId"].ToString();
                    rdoReward.SelectedValue = dtTicketId.Rows[0]["Reward_Id"].ToString();
                    txtTicketPrice.Text = dtTicketId.Rows[0]["TicketPrice"].ToString();
                    txtImagename.Text = dtTicketId.Rows[0]["ImageName"].ToString();
                    txtScratchPrice.Text = dtTicketId.Rows[0]["ScratchPrize"].ToString();
                    bindThemes();
                    ddlThemes.SelectedValue = dtTicketId.Rows[0]["ThemeId"].ToString();
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
    protected void BindLevels()
    {
        ddlLevel.DataSource = admin.getLevel();
        ddlLevel.DataTextField = "LevelNo";
        ddlLevel.DataValueField = "LevelId";
        ddlLevel.DataBind();
        ddlLevel.Items.Insert(0, new ListItem("Select Level", "-1"));
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["TID"]))
        {
            if (admin.UpdateTicketData(Request.QueryString["TID"], ddlType.SelectedValue, ddlLevel.SelectedValue, ddlThemes.SelectedValue, txtTicketPrice.Text, txtScratchPrice.Text, txtImagename.Text, rdoReward.SelectedValue) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "update", "alert('Successfully Updated.');window.location='Tickets.aspx';", true);
                ClearAllControl();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "update", "alert('Problem to Update the data.');window.location='Tickets.aspx';", true);
            }
        }
        else
        {
            if (admin.InsertTicketData(ddlType.SelectedValue, ddlLevel.SelectedValue, ddlThemes.SelectedValue, txtTicketPrice.Text, txtScratchPrice.Text, txtImagename.Text, rdoReward.SelectedValue) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "insert", "alert('Successfully Saved.');", true);
                ClearAllControl();
                BindTickets();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "insert", "alert('Problem to save the data.');", true);
            }
        }

    }
    public void ClearAllControl()
    {
        ddlLevel.SelectedValue = "-1";
        ddlThemes.SelectedValue = "-1";
        ddlType.SelectedValue = "-1";
        txtTicketPrice.Text = "";
        txtScratchPrice.Text = "";
        txtImagename.Text = "";

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ddlLevel.SelectedValue = "-1";
        ddlThemes.SelectedValue = "-1";
        ddlType.SelectedValue = "-1";
        txtTicketPrice.Text = "";
        txtScratchPrice.Text = "";
        txtImagename.Text = "";
    }

    protected void bindThemes()
    {
        DataView dvTheme = new DataView(admin.getThemes());
        dvTheme.RowFilter = "LevelId=" + ddlLevel.SelectedValue + "";
        if (dvTheme.Count > 0)
        {
            ddlThemes.DataSource = dvTheme;
            ddlThemes.DataTextField = "ThemeName";
            ddlThemes.DataValueField = "Id";
            ddlThemes.DataBind();
            ddlThemes.Items.Insert(0, new ListItem("Select Theme", "-1"));
        }
        else
        {
            ddlThemes.DataSource = null;
            ddlThemes.DataBind();
        }
        
    }
    protected void BindTicketType()
    {
        ddlType.DataSource = admin.getTicketType();
        ddlType.DataTextField = "TicketType";
        ddlType.DataValueField = "Id";
        ddlType.DataBind();
        ddlType.Items.Insert(0, new ListItem("Select Ticket Type", "-1"));
    }
    protected void grdTicket_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btnEdit")
        {
            Response.Redirect("Tickets.aspx?TID=" + Convert.ToInt32(e.CommandArgument) + "");
        }
        else if (e.CommandName == "btnActive")
        {
            admin.ActivateTicketStatus(Convert.ToString(e.CommandArgument));
        }
        else if (e.CommandName == "btnDelete")
        {
            admin.DeleteTicketStatus(Convert.ToString(e.CommandArgument));
        }
        BindTickets();
    }
    private void BindTickets()
    {
        DataTable dtTicket = admin.FillTicketGrid();
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
        BindTickets();
    }
    protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindThemes();
    }
}