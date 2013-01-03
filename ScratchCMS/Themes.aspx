<%@ Page Title="Themes" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Themes.aspx.cs" Inherits="Themes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table width="100%">
        <tr>
            <td width="100%">
                <table width="100%">
                 <tr>
                        <td align="right">
                            Select Level :
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlLevel" runat="server">
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
                            Theme Name :
                        </td>
                        <td>
                            <asp:TextBox ID="txtThemeName" runat="server" Width="254px" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                ControlToValidate="txtThemeName" Display="Dynamic"> </asp:RequiredFieldValidator>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Theme Description :
                        </td>
                        <td>
                            <asp:TextBox ID="txtThemeDesc" runat="server" Width="254px" TextMode="MultiLine"></asp:TextBox>
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
                            <asp:TextBox ID="txtImagename" runat="server" Width="254px"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                     <tr>
                        <td align="right">
                            Image Name1
                        </td>
                        <td>
                            <asp:TextBox ID="txtImagename1" runat="server" Width="254px"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnCancel" runat="server" CausesValidation="false" Text="Cancel"
                                OnClick="btnCancel_Click" Style="height: 26px" />
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
                            <asp:GridView ID="grdThemes" runat="server" AutoGenerateColumns="false" OnRowCommand="grdTheme_RowCommand"
                                AllowPaging="true" PageSize="10" OnPageIndexChanging="pageindexchange">
                                <Columns>
                                    <asp:TemplateField HeaderText="Serial" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblThemeId" runat="server" Text="<%#bind('Id') %>"></asp:Label>
                                            <%-- <asp:Label ID="lblSerial" runat="server" Text="<%#bind('Serial') %>" ></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Level" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblLevel" runat="server" Text="<%#bind('Levelno') %>"></asp:Label>
                                            <%-- <asp:Label ID="lblSerial" runat="server" Text="<%#bind('Serial') %>" ></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Name" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblName" runat="server" Text="<%#bind('ThemeName') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description" HeaderStyle-Width="40%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text="<%#bind('ThemeDesc') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" HeaderStyle-Width="20%">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnEdit" runat="server" ValidationGroup="grpAction" ImageUrl="~/Images/edit.gif"
                                                CommandName="btnEdit" CommandArgument="<%#bind('Id') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnActive" runat="server" ValidationGroup="grpAction" ToolTip="click here to activate"
                                                ImageUrl="~/Images/approve.png" Visible='<%#DataBinder.Eval(Container.DataItem,"IsActive").ToString()=="True"?false:true%>'
                                                CommandName="btnActive" CommandArgument="<%#bind('Id') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnDeActive" runat="server" ValidationGroup="grpAction" ToolTip="click here to deactivate"
                                                ImageUrl="~/Images/rejected.png" Visible="<%# bind('IsActive')%>" CommandName="btnActive"
                                                CommandArgument="<%#bind('Id') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" ValidationGroup="grpAction" ImageUrl="~/Images/Cancel.jpg"
                                                CommandName="btnDelete" CommandArgument="<%#bind('Id') %>"></asp:ImageButton>
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
