<%@ Page Title="Bank" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Bank.aspx.cs" Inherits="Bank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 260px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table width="100%">
        <tr>
           <td width="100%">
                <table width="100%">
                    <tr>
                        <td align="right" class="style1">
                            Price :
                        </td>
                        <td>
                            <asp:TextBox ID="txtPrice" runat="server" Width="254px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                ControlToValidate="txtPrice" Display="Dynamic"> </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*"
                                ControlToValidate="txtPrice" Display="Dynamic" ValidationExpression="\d+\.?\d*"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style1">
                            HorseShoes :
                        </td>
                        <td>
                            <asp:TextBox ID="txtHorseShoes" runat="server" Width="254px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                ControlToValidate="txtHorseShoes" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*"
                                Display="Dynamic" ControlToValidate="txtHorseShoes" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
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
                        <td class="style1">
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
                            <asp:GridView ID="grdBank" runat="server" AutoGenerateColumns="false" OnRowCommand="grdBank_RowCommand"
                                AllowPaging="true" PageSize="10" OnPageIndexChanging="pageindexchange">
                                <Columns>
                                    <asp:TemplateField HeaderText="Serial" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblId" runat="server" Text="<%#bind('Id') %>"></asp:Label>
                                            <%-- <asp:Label ID="lblSerial" runat="server" Text="<%#bind('Serial') %>" ></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Price" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPrice" runat="server" Text="<%#bind('Price') %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Horseshoe" HeaderStyle-Width="40%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblHorseshoe" runat="server" Text="<%#bind('points') %>"></asp:Label>
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
