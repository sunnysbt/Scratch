<%@ Page Title="tickets" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Tickets.aspx.cs" Inherits="Tickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table width="100%">
        <tr>
            <td width="100%">
                <table width="100%">
                    <tr>
                        <td align="right">
                            Select Ticket Type :
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlType" runat="server" Width="277px">
                                <asp:ListItem Text="Select Ticket Type" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlType"
                                InitialValue="-1" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Select Level :
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlLevel" runat="server" AutoPostBack="True" 
                                onselectedindexchanged="ddlLevel_SelectedIndexChanged">
                                <asp:ListItem Text="Select Level" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlLevel"
                                InitialValue="-1" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Select Theme :
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlThemes" runat="server">
                                <asp:ListItem Text="Select Theme" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlThemes"
                                InitialValue="-1" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Ticket Price :
                        </td>
                        <td>
                            <asp:TextBox ID="txtTicketPrice" runat="server" Width="254px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                ControlToValidate="txtTicketPrice" Display="Dynamic"> </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*"
                                ControlToValidate="txtTicketPrice" Display="Dynamic" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Image Name
                        </td>
                        <td>
                            <asp:TextBox ID="txtImagename" runat="server" Width="223px"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Select Reward :
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rdoReward" runat="server" AutoPostBack="true" RepeatDirection="Vertical">
                                <asp:ListItem Value="1">No Reward</asp:ListItem>
                                <asp:ListItem Value="2">3 Icon</asp:ListItem>
                                <asp:ListItem Value="3">Horse Shoe Dollors</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <%if (rdoReward.SelectedValue == "3")
                      {%>
                    <tr>
                        <td align="right">
                            Set Amount of Win
                        </td>
                        <td>
                            <asp:TextBox ID="txtScratchPrice" runat="server" Width="254px"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <%} %>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnCancel" runat="server" CausesValidation="false" Text="Cancel"
                                OnClick="btnCancel_Click" />
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <table width="80%" align="center">
                    <tr>
                        <td width="100%">
                            <asp:GridView ID="grdTickets" runat="server" AutoGenerateColumns="false" OnRowCommand="grdTicket_RowCommand"
                                AllowPaging="true" PageSize="10" OnPageIndexChanging="pageindexchange">
                                <Columns>
                                    <asp:TemplateField HeaderText="Serial" HeaderStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblLevelId" runat="server" Text="<%#bind('TicketId') %>"></asp:Label>
                                            <%-- <asp:Label ID="lblSerial" runat="server" Text="<%#bind('Serial') %>" ></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Type" HeaderStyle-Width="30%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblType" runat="server" Text="<%#bind('TicketType') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Level No" HeaderStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblLevelno" runat="server" Text="<%#bind('Levelno') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Theme Name" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblThemeName" runat="server" Text="<%#bind('ThemeName') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Ticket Price" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTicketPrice" runat="server" Text="<%#bind('TicketPrice') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Scratch Prize" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblScratchPrize" runat="server" Text="<%#bind('ScratchPrize')%>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnEdit" runat="server" ValidationGroup="grpAction" ImageUrl="~/Images/edit.gif"
                                                CommandName="btnEdit" CommandArgument="<%#bind('TicketId') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnActive" runat="server" ValidationGroup="grpAction" ToolTip="click here to activate"
                                                ImageUrl="~/Images/approve.png" Visible='<%#DataBinder.Eval(Container.DataItem,"IsActive").ToString()=="True"?false:true%>'
                                                CommandName="btnActive" CommandArgument="<%#bind('TicketId') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnDeActive" runat="server" ValidationGroup="grpAction" ToolTip="click here to deactivate"
                                                ImageUrl="~/Images/rejected.png" Visible="<%# bind('IsActive')%>" CommandName="btnActive"
                                                CommandArgument="<%#bind('TicketId') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" ValidationGroup="grpAction" ImageUrl="~/Images/Cancel.jpg"
                                                CommandName="btnDelete" CommandArgument="<%#bind('TicketId') %>"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
