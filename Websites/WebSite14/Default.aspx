<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Welcome to ASP.NET!
    </h2>
    <p>
        To learn more about ASP.NET visit <a href="http://www.asp.net" title="ASP.NET Website">www.asp.net</a>.
    </p>
    <p>
        You can also find <a href="http://go.microsoft.com/fwlink/?LinkID=152368&amp;clcid=0x409"
            title="MSDN ASP.NET Docs">documentation on ASP.NET at MSDN</a>.
    </p>

<table align="center">
<tr>
<td colspan="2" align="center">
<b>User Registration</b>
</td>
</tr>
<tr>
<td>
UserName:
</td>
<td>
<asp:TextBox ID="txtUserName" runat="server"/>
</td>
</tr>
<tr>
<td>
FirstName:
</td>
<td>
<asp:TextBox ID="txtfname" runat="server"/>
</td>
</tr>
<tr>
<td>
LastName:
</td>
<td>
<asp:TextBox ID="txtlname" runat="server"/>
</td>
</tr>
<tr>
<td class="style1">
Location:
</td>
<td class="style1">
<asp:TextBox ID="txtlocation" runat="server"/>
</td>
</tr>
<tr>
<td>
</td>
<td>
<asp:Button ID="btnSubmit" runat="server" Text="Submit" onclick="btnSubmit_Click" 
          />
</td>
</tr>
<tr>
<td colspan="2">
<asp:Label ID="lblResult" runat="server"/>
</td>
</tr>
<tr>
<td colspan="2">
<asp:GridView runat="server" ID="gvDetails" AutoGenerateColumns="false">
<RowStyle BackColor="#EFF3FB" />
<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
<AlternatingRowStyle BackColor="White" />
<Columns>
<asp:BoundField HeaderText="UserName" DataField="UserName" />
<asp:BoundField HeaderText="FirstName" DataField="FirstName" />
<asp:BoundField HeaderText="LastName" DataField="LastName" />
<asp:BoundField HeaderText="Location" DataField="Location" />
</Columns>
</asp:GridView>
</td>
</tr>
</table>

</asp:Content>

