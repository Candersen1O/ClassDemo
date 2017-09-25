<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="samplepage_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Albums by Year range</h1>
    <asp:Label ID="Min" runat="server" Text="Enter Min Year:"></asp:Label><asp:TextBox ID="minyear" runat="server"></asp:TextBox><br />
    <asp:Label ID="Max" runat="server" Text="Enter Max Year:"></asp:Label><asp:TextBox ID="maxyear" runat="server"></asp:TextBox><asp:Button ID="Button1" runat="server" Text="click" />
    <br /><br />
    <asp:GridView ID="AlbumsList" runat="server" AutoGenerateColumns="False" DataSourceID="AlbumsListODS" AllowPaging="True">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
            <asp:BoundField DataField="ArtistId" HeaderText="ArtistId" SortExpression="ArtistId"></asp:BoundField>
            <asp:BoundField DataField="ReleaseYear" HeaderText="ReleaseYear" SortExpression="ReleaseYear"></asp:BoundField>
            <asp:BoundField DataField="ReleaseLabel" HeaderText="ReleaseLabel" SortExpression="ReleaseLabel"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="AlbumsListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Albums_FindInYears" TypeName="ChinookSystem.BLL.AlbumController">
        <SelectParameters>
            <asp:ControlParameter ControlID="minyear" PropertyName="Text" Name="minyear" Type="Int32" DefaultValue="1950"></asp:ControlParameter>
            <asp:ControlParameter ControlID="maxyear" PropertyName="Text" Name="maxyear" Type="Int32" DefaultValue="2017" ></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

