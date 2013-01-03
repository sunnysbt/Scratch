<%@ Page Title="Collectibles" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Collectibles.aspx.cs" Inherits="Collectibles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table width="100%">
        <tr>
            <td width="100%">
                <table width="100%">
                    
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
                            Enter Name :
                        </td>
                        <td>
                            <asp:TextBox ID="txtName" runat="server" Width="254px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                ControlToValidate="txtName" Display="Dynamic"> </asp:RequiredFieldValidator>
                            
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Image Name1
                        </td>
                        <td>
                            <asp:TextBox ID="txtImagename1" runat="server" Width="223px"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Image Name2
                        </td>
                        <td>
                            <asp:TextBox ID="txtImagename2" runat="server" Width="223px"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                           Can be purchase against 
                            <br />
                            lucky horseshoe Dollars :
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rdopurchase" runat="server" AutoPostBack="true" RepeatDirection="Horizontal">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <%if (rdopurchase.SelectedValue == "1")
                      {%>
                    <tr>
                        <td align="right">
                            Enter Price
                        </td>
                        <td>
                            <asp:TextBox ID="txtPrice" runat="server" Width="254px"></asp:TextBox>
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
                <table width="50%" align="center">
                    <tr>
                        <td width="100%">
                            <asp:GridView ID="grdTickets" runat="server" AutoGenerateColumns="false" OnRowCommand="grdTicket_RowCommand"
                                AllowPaging="true" PageSize="10" OnPageIndexChanging="pageindexchange">
                                <Columns>
                                    <asp:TemplateField HeaderText="Serial" HeaderStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblColId" runat="server" Text="<%#bind('Col_Id') %>"></asp:Label>
                                            <%-- <asp:Label ID="lblSerial" runat="server" Text="<%#bind('Serial') %>" ></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Theme Name" HeaderStyle-Width="20%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblThemeName" runat="server" Text="<%#bind('ThemeName') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Collectibles Name" HeaderStyle-Width="35%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblcolName" runat="server" Text="<%#bind('colName') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnEdit" runat="server" ValidationGroup="grpAction" ImageUrl="~/Images/edit.gif"
                                                CommandName="btnEdit" CommandArgument="<%#bind('Col_Id') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnActive" runat="server" ValidationGroup="grpAction" ToolTip="click here to activate"
                                                ImageUrl="~/Images/approve.png" Visible='<%#DataBinder.Eval(Container.DataItem,"IsActive").ToString()=="True"?false:true%>'
                                                CommandName="btnActive" CommandArgument="<%#bind('Col_Id') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnDeActive" runat="server" ValidationGroup="grpAction" ToolTip="click here to deactivate"
                                                ImageUrl="~/Images/rejected.png" Visible="<%# bind('IsActive')%>" CommandName="btnActive"
                                                CommandArgument="<%#bind('Col_Id') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" ValidationGroup="grpAction" ImageUrl="~/Images/Cancel.jpg"
                                                CommandName="btnDelete" CommandArgument="<%#bind('Col_Id') %>"></asp:ImageButton>
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
