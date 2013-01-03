<%@ Page Title="Levels" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Levels.aspx.cs" Inherits="Levels" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
     <table width="100%">
        <tr>
           <td width="100%">
                <table width="100%">
                    <tr>
                        <td align="right">
                            Level :
                        </td>
                        <td>
                            <asp:TextBox ID="txtLevel" runat="server" Width="254px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                ControlToValidate="txtLevel" Display="Dynamic"> </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*"
                                ControlToValidate="txtLevel" Display="Dynamic" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Number Of Ticket :
                        </td>
                        <td>
                            <asp:TextBox ID="txtNumberOfTicket" runat="server" Width="254px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                ControlToValidate="txtNumberOfTicket" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*"
                                Display="Dynamic" ControlToValidate="txtNumberOfTicket" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
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
                            <asp:GridView ID="grdlevels" runat="server" AutoGenerateColumns="false" 
                                OnRowCommand="grdLevel_RowCommand" AllowPaging="true" PageSize="10" 
                                onpageindexchanging="pageindexchange" onrowdatabound="grdLevel_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Serial" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblLevelId" runat="server" Text="<%#bind('LevelId') %>"></asp:Label>
                                            <%-- <asp:Label ID="lblSerial" runat="server" Text="<%#bind('Serial') %>" ></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Level" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblLevelNo" runat="server" Text="<%#bind('LevelNo') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Number of Tickets" HeaderStyle-Width="40%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNoTicket" runat="server" Text="<%#bind('NumberofTicket') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action" HeaderStyle-Width="20%">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgbtnEdit" runat="server" ValidationGroup="grpAction" ImageUrl="~/Images/edit.gif"
                                                CommandName="btnEdit" CommandArgument="<%#bind('LevelId') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnActive" runat="server" ValidationGroup="grpAction" ToolTip="click here to activate"
                                                ImageUrl="~/Images/approve.png" Visible='<%#DataBinder.Eval(Container.DataItem,"IsActive").ToString()=="True"?false:true%>'
                                                CommandName="btnActive" CommandArgument="<%#bind('LevelId') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnDeActive" runat="server" ValidationGroup="grpAction" ToolTip="click here to deactivate"
                                                ImageUrl="~/Images/rejected.png" Visible="<%# bind('IsActive')%>" CommandName="btnActive"
                                                CommandArgument="<%#bind('LevelId') %>"></asp:ImageButton>
                                            <asp:ImageButton ID="imgbtnDelete" runat="server" ValidationGroup="grpAction" ImageUrl="~/Images/Cancel.jpg"
                                                CommandName="btnDelete" CommandArgument="<%#bind('LevelId') %>"></asp:ImageButton>
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
