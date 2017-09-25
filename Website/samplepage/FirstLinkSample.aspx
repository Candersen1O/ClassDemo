<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="FirstLinkSample.aspx.cs" Inherits="samplepage_FirstLinkSample" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Albums for Artist</h1>
    <asp:Label ID="Label2" runat="server" Text="pick something, dummy!"></asp:Label>
    <asp:DropDownList ID="ArtistList" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId"></asp:DropDownList>
    <asp:Button ID="Button1" runat="server" Text="GO" /><br />
    <asp:GridView ID="ArtistAlbumsList" runat="server" AutoGenerateColumns="False" DataSourceID="ArtistAlbumsListODS" AllowPaging="True">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
            <asp:BoundField DataField="Released" HeaderText="Released" SortExpression="Released"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ArtistAlbumsListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Albums_ByArtist" TypeName="ChinookSystem.BLL.AlbumController">
        <SelectParameters>
            <asp:ControlParameter ControlID="ArtistList" PropertyName="SelectedValue" DefaultValue="0" Name="artistid" Type="Int32"></asp:ControlParameter>

        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ArtistListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Artist_List" TypeName="ChinookSystem.BLL.artistcontroller"></asp:ObjectDataSource>
</asp:Content>


