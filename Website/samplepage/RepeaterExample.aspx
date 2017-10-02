<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="RepeaterExample.aspx.cs" Inherits="samplepage_RepeaterExample" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Repeater Example</h1>
    <h2>Albums and their tracks by Genre</h2>

    <!-- Inside a repeater you need a minimum of a item tremplate otehr templates include Headertemplate, footertemplate, alternatingitemtemplate, seperatortemplate, 
        
        outer repater will display the first fields from the DTO class which do not repeat 
        outer repeater gets it's data from an ODS
        (Nested/)inner repeater will display the collection of the DTO file
        (Nested/)inner repeater will get its' data source from the collection of the DTO class(either a POCO or another DTO)
        
        
        This Patter nrepeats for  all levels of your dataset.-->

    <asp:Repeater ID="GenreAlbumTrackList" runat="server" DataSourceID="GenreAlbumTrackListODS" ItemType="Chinook.Data.DTOs.GenreDTO">
        <ItemTemplate>
            <h2>Genre: <%# Eval("genre") %></h2>
            <asp:Repeater ID="GenreAlbums" runat="server"
                DataSource='<%# Eval("albums") %>' ItemType="Chinook.Data.DTOs.AlbumDTO">
                <ItemTemplate>
                    <strong>Album:
                         <%# string.Format("{0} ({1}) Tracks: {2}", Eval("title"), Eval("year"), Eval("numotracks")) %></strong><br />
                    <asp:Repeater ID="AlbumTracksList" runat="server" DataSource="<%# Item.tracks %>" ItemType="Chinook.Data.POCOs.TrackPOCO">
                        <HeaderTemplate>
                            <table>
                                <tr>
                                    <th>Song</th>
                                    <th>Length</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td style="width: 600px"><%# Item.song %></td>
                                
                                <td><%# Item.ALENGTH %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>

                    </asp:Repeater>
                </ItemTemplate>
                <SeparatorTemplate>
                    <hr style="height:4px; color:blue;"/>
                </SeparatorTemplate>
            </asp:Repeater>
        </ItemTemplate>
    </asp:Repeater>
    <asp:ObjectDataSource ID="GenreAlbumTrackListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="ListAlbumsbyGenre" TypeName="ChinookSystem.BLL.GenreController"></asp:ObjectDataSource>


</asp:Content>

