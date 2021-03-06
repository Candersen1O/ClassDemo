﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TabbedCRUDReview.aspx.cs" Inherits="SamplePages_TabbedCRUDReview" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row jumbotron">
        <h1>Tabbed CRUD REview</h1>
        
    </div>
    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <div class="row">
        <div class="col-md-12">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs">
                <li class="active"><a href="#search" data-toggle="tab">Lookup</a></li>
                <li><a href="#crud" data-toggle="tab">Add Update Delete</a></li>
                <li><a href="#listviewcrud" data-toggle="tab">ListView Crud</a></li>
                <li><a href="#sad" data-toggle="tab">:(</a></li>
            </ul>
            <!-- tab content area -->
            <div class="tab-content">
                <!-- user tab -->



                <div class="tab-pane fade" id="sad">
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <p>
                                :(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(
                                <asp:Label ID="Label1" runat="server"></asp:Label>

                                :(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(:(
                            </p>

                            <%-- Security- 
                                hardware security - sepertate systems into seperate physical machines. Firewalls, 
                                software- os, windows nt authentication, form authentication, set up for user/user group.certain users gain access to certain systems. Roles. userroles. test for permissions. login & roles. check via web server & application server. database server can also grant or restrict permissions.
                                personel-human factor
                                software cont- we need to create classes to represent users and roles. Security framework methods.
                                --%>

                            <asp:ObjectDataSource ID="sadod" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Artist_List" TypeName="ChinookSystem.BLL.artistcontroller"></asp:ObjectDataSource>

                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>




                <div class="tab-pane fade in active" id="search">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            Enter Album Name:
                            <asp:TextBox ID="SearchArgAlbum" runat="server"></asp:TextBox>
                            <asp:Button ID="Fetch" runat="server" Text="Fetch" /><br />
                            <asp:GridView ID="SearchResults" runat="server"
                                AutoGenerateColumns="False" DataSourceID="SearchResultsODS"
                                AllowPaging="True" GridLines="None"
                                OnSelectedIndexChanged="SearchResults_SelectedIndexChanged" OnPageIndexChanging="SearchResults_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("AlbumId") %>'
                                                ID="AlbumID" Visible="false"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title"></asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:DropDownList runat="server"
                                                ID="ArtistList"
                                                DataSourceID="ArtistListODS"
                                                DataTextField="Name"
                                                DataValueField="ArtistId"
                                                SelectedValue='<%# Bind("ArtistID") %>'>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ReleaseYear" HeaderText="ReleaseYear" SortExpression="ReleaseYear"></asp:BoundField>
                                    <asp:BoundField DataField="ReleaseLabel" HeaderText="ReleaseLabel" SortExpression="ReleaseLabel"></asp:BoundField>
                                    <asp:CommandField SelectText="View" ShowSelectButton="True"></asp:CommandField>

                                </Columns>
                                <SelectedRowStyle BackColor="#99CCFF" />
                            </asp:GridView>
                            <asp:ObjectDataSource ID="SearchResultsODS" runat="server"
                                OldValuesParameterFormatString="original_{0}"
                                SelectMethod="Albums_ListByTitle"
                                TypeName="ChinookSystem.BLL.AlbumController">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="SearchArgAlbum"
                                        PropertyName="Text" DefaultValue="zxzx" Name="title"
                                        Type="String"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
                <%--eop--%>
                <!-- role tab -->
                <div class="tab-pane fade" id="crud">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Message" runat="server"></asp:Label>
                            <table>
                                <tr>
                                    <td>Album ID:</td>
                                    <td>
                                        <asp:Label ID="AlbumID" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Title:</td>
                                    <td>
                                        <asp:TextBox ID="AlbumTitle" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Artist:</td>
                                    <td>
                                        <asp:DropDownList ID="ArtistList" runat="server"
                                            DataSourceID="ArtistListODS"
                                            DataTextField="Name"
                                            DataValueField="ArtistId">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Release Year:</td>
                                    <td>
                                        <asp:TextBox ID="ReleaseYear" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Release Label:</td>
                                    <td>
                                        <asp:TextBox ID="ReleaseLabel" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="Add" runat="server" Text="Add" Width="100px" OnClick="Add_Click" />&nbsp;&nbsp;
                                   <asp:Button ID="Update" runat="server" Text="Update" Width="100px" OnClick="Update_Click" />&nbsp;&nbsp;
                                   <asp:Button ID="Delete" runat="server" Text="Delete" Width="100px" OnClick="Delete_Click" />&nbsp;&nbsp;
                                   <asp:Button ID="Clear" runat="server" Text="Clear" Width="100px" OnClick="Clear_Click" />
                                    </td>
                                </tr>
                            </table>
                            <asp:ObjectDataSource ID="ArtistListODS" runat="server"
                                OldValuesParameterFormatString="original_{0}"
                                SelectMethod="Artists_List"
                                TypeName="ChinookSystem.BLL.artistcontroller"></asp:ObjectDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
                <%--eop--%>
                <!-- unregistered user tab -->
                <div class="tab-pane fade" id="listviewcrud">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <asp:ListView ID="ListViewcrud" runat="server" DataSourceID="listviewODS" InsertItemPosition="LastItem" DataKeyNames="AlbumID">

                                <AlternatingItemTemplate>
                                    <tr style="background-color: aqua; border: double">
                                        <td>
                                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                        </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("AlbumId") %>' runat="server" ID="AlbumIdLabel" Width="50px" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                                        <td>
                                            <%--<asp:Label Text='<%# Eval("ArtistId") %>' runat="server" ID="ArtistIdLabel" />--%>

                                            <asp:DropDownList ID="ArtistIdDDL" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId" SelectedValue='<%# Eval("ArtistId") %>'></asp:DropDownList>

                                        </td>
                                        <td align="center">
                                            <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" Width="50px" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /></td>
                                        <%--<td>
                                            <asp:Label Text='<%# Eval("Artist") %>' runat="server" ID="ArtistLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Tracks") %>' runat="server" ID="TracksLabel" /></td>--%>
                                    </tr>
                                </AlternatingItemTemplate>
                                <EditItemTemplate>
                                    <tr style="background-color: black; border: double">
                                        <td>
                                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                                            <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                                        </td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("AlbumId") %>' runat="server" ID="AlbumIdTextBox" Width="50px" Enabled="False" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBox" /></td>
                                        <td>
                                            <%--<asp:TextBox Text='<%# Bind("ArtistId") %>' runat="server" ID="ArtistIdTextBox" /></td>--%>
                                            <asp:DropDownList ID="ArtistIdDDL" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId" SelectedValue='<%# Bind("ArtistId") %>'></asp:DropDownList>

                                        <td align="center">
                                            <asp:TextBox Text='<%# Bind("ReleaseYear") %>' runat="server" ID="ReleaseYearTextBox" Width="50px" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("ReleaseLabel") %>' runat="server" ID="ReleaseLabelTextBox" /></td>
                                        <%-- <td>
                                            <asp:TextBox Text='<%# Bind("Artist") %>' runat="server" ID="ArtistTextBox" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("Tracks") %>' runat="server" ID="TracksTextBox" /></td>--%>
                                    </tr>
                                </EditItemTemplate>
                                <EmptyDataTemplate>
                                    <table runat="server" style="border: double">
                                        <tr>
                                            <td>No data was returned.</td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <InsertItemTemplate>
                                    <tr style="border: double">
                                        <td>
                                            <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                                            <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                                        </td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("AlbumId") %>' runat="server" ID="AlbumIdTextBox" Width="50px" Enabled="False" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBox" /></td>
                                        <td>
                                            <%--<asp:TextBox Text='<%# Bind("ArtistId") %>' runat="server" ID="ArtistIdTextBox" /></td>--%>
                                            <asp:DropDownList ID="ArtistIdDDL" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId" SelectedValue='<%# Bind("ArtistId") %>'></asp:DropDownList>

                                        <td align="center">
                                            <asp:TextBox Text='<%# Bind("ReleaseYear") %>' runat="server" ID="ReleaseYearTextBox" Width="50px" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("ReleaseLabel") %>' runat="server" ID="ReleaseLabelTextBox" /></td>
                                        <%--  <td>
                                            <asp:TextBox Text='<%# Bind("Artist") %>' runat="server" ID="ArtistTextBox" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("Tracks") %>' runat="server" ID="TracksTextBox" /></td>--%>
                                    </tr>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <tr style="border: double">
                                        <td>
                                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                        </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("AlbumId") %>' runat="server" ID="AlbumIdLabel" Width="50px" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                                        <td>
                                            <%--<asp:Label Text='<%# Eval("ArtistId") %>' runat="server" ID="ArtistIdLabel" /></td>--%>
                                            <asp:DropDownList ID="ArtistIdDDL" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId" SelectedValue='<%# Eval("ArtistId") %>'></asp:DropDownList>

                                        <td align="center">
                                            <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" Width="50px" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /></td>
                                        <%--<td>
                                            <asp:Label Text='<%# Eval("Artist") %>' runat="server" ID="ArtistLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Tracks") %>' runat="server" ID="TracksLabel" /></td>--%>
                                    </tr>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <table runat="server">
                                        <tr runat="server">
                                            <td runat="server">
                                                <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                                    <tr runat="server" style="">
                                                        <th runat="server"></th>
                                                        <th runat="server">ID</th>
                                                        <th runat="server">Title</th>
                                                        <th runat="server">Artist</th>
                                                        <th runat="server">Release Year</th>
                                                        <th runat="server">Release Label</th>
                                                        <%-- <th runat="server">Artist</th>
                                                        <th runat="server">Tracks</th>--%>
                                                    </tr>
                                                    <tr runat="server" id="itemPlaceholder"></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" style="">
                                                <asp:DataPager runat="server" ID="DataPager1">
                                                    <Fields>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                                    </Fields>
                                                </asp:DataPager>
                                            </td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                                <SelectedItemTemplate>
                                    <tr style="border: double">
                                        <td>
                                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                        </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("AlbumId") %>' runat="server" ID="AlbumIdLabel" Width="50px" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                                        <td>
                                            <%--<asp:Label Text='<%# Eval("ArtistId") %>' runat="server" ID="ArtistIdLabel" /></td>--%>
                                            <asp:DropDownList ID="ArtistIdDDL" runat="server" DataSourceID="ArtistListODS" DataTextField="Name" DataValueField="ArtistId" SelectedValue='<%# Eval("ArtistId") %>'></asp:DropDownList>

                                        <td align="center">
                                            <asp:Label Text='<%# Eval("ReleaseYear") %>' runat="server" ID="ReleaseYearLabel" Width="50px" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("ReleaseLabel") %>' runat="server" ID="ReleaseLabelLabel" /></td>
                                        <%--            <td>
                                            <asp:Label Text='<%# Eval("Artist") %>' runat="server" ID="ArtistLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Tracks") %>' runat="server" ID="TracksLabel" /></td>--%>
                                    </tr>
                                </SelectedItemTemplate>
                            </asp:ListView>
                            <asp:ObjectDataSource ID="listviewODS" runat="server"
                                DataObjectTypeName="Chinook.Data.Entities.Album"
                                DeleteMethod="Albums_Delete"
                                InsertMethod="Albums_Add"
                                UpdateMethod="Albums_Update"
                                OldValuesParameterFormatString="original_{0}"
                                SelectMethod="Albums_List"
                                TypeName="ChinookSystem.BLL.AlbumController"
                                OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException" OnSelected="CheckForException">

                                <SelectParameters>
                                    <asp:Parameter Name="item" Type="Object"></asp:Parameter>
                                </SelectParameters>
                            </asp:ObjectDataSource>

                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
                <%--eop--%>
            </div>
        </div>
        <%-- some people place all ODS contrls in one location for  ease of use. not necessary. any ods is available to all tabs--%>
        <%-- install radiobuttons use edit items to create individual selection. can change the defualt vertical layout by chaning the control properties.
        remember to include selectedvalue attribute--%>
    </div>
</asp:Content>

