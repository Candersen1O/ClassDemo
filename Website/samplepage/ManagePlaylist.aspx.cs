using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region Additional Namespaces
using ChinookSystem.BLL;
using Chinook.Data.POCOs;

#endregion
public partial class SamplePages_ManagePlaylist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.IsAuthenticated)
        {
            Response.Redirect("~/Account/Login.aspx");
        }
        else
        {
            TracksSelectionList.DataSource = null;
        }
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        //PreRenderComplete occurs just after databinding page events
        //load a pointer to point to your DataPager control
        DataPager thePager = TracksSelectionList.FindControl("DataPager1") as DataPager;
        if (thePager != null)
        {
            //this code will check the StartRowIndex to see if it is greater that the
            //total count of the collection
            if (thePager.StartRowIndex > thePager.TotalRowCount)
            {
                thePager.SetPageProperties(0, thePager.MaximumRows, true);
            }
        }
    }

    protected void ArtistFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "Artist";
        SearchArgID.Text = ArtistDDL.SelectedValue;
        TracksSelectionList.DataBind();
    }

    protected void MediaTypeFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "MediaType";
        SearchArgID.Text = MediaTypeDDL.SelectedValue;
        TracksSelectionList.DataBind();
    }

    protected void GenreFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "Genre";
        SearchArgID.Text = GenreDDL.SelectedValue;
        TracksSelectionList.DataBind();
    }

    protected void AlbumFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "Album";
        SearchArgID.Text = AlbumDDL.SelectedValue;
        TracksSelectionList.DataBind();
    }

    protected void PlayListFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        //standard query implementation
        if (string.IsNullOrEmpty(PlaylistName.Text))
        {
            //throw error message
            //use usercontrolmessage. MessageUserControl
            MessageUserControl.ShowInfo("Warning...", "Playlist Name is required...");
            //the user control will be the mechanism to display messages on this form
        }
        else
        {
            //no need for try catches, the MEssageUserControl has the trycatch coding built inside it
            //
            MessageUserControl.TryRun(() =>
            {
                //this is the process coding block to be executed under the "watchful eye" of the MUC
                //
                //obtain username from the security part of the application
                string username = User.Identity.Name;
                PlaylistTracksController sysmgr = new PlaylistTracksController();
                List<UserPlaylistTrack> playlist = sysmgr.List_TracksForPlaylist(PlaylistName.Text, username);
                PlayList.DataSource = playlist;
                PlayList.DataBind();
            }, "", "Here is your current playlist");
        }
    }

    protected void TracksSelectionList_ItemCommand(object sender,
        ListViewCommandEventArgs e)
    {
        //ListViewCommandEventArgs parameter e contains the commandarg value (in this case TrackID)
        if (string.IsNullOrEmpty(PlaylistName.Text))
        {
            MessageUserControl.ShowInfo("", "bad end");
        }
        else
        {
            string username = User.Identity.Name;
            //track id is going to come from e.CommandArgument
            //e.comarg is Antlr object so needs to be a string
            int trackid = int.Parse(e.CommandArgument.ToString());
            //the following code calls a BLL method to add to the database
            MessageUserControl.TryRun(() =>
            {
                PlaylistTracksController sysmgr = new PlaylistTracksController();
                List<UserPlaylistTrack> refreshresults = sysmgr.Add_TrackToPLaylist(PlaylistName.Text, username, trackid);
                PlayList.DataSource = refreshresults;
                PlayList.DataBind();
            }, "Sucess", "Added to Playlist"
            );
        }
    }

    protected void MoveUp_Click(object sender, EventArgs e)
    {
        //code to go here
        if (PlayList.Rows.Count == 0)
        {
            MessageUserControl.ShowInfo("BAD", "No playlist has been retrieved");

        }
        else
        {
            if (String.IsNullOrEmpty(PlaylistName.Text))
            {
                MessageUserControl.ShowInfo("bad", "no playlist name. gimee");
            }
            else
            {
                //check that one, and only one, row is selected
                int trackid = -1;
                int tracknumber = -1; //optional
                int rowselect = 0;//flag
                //create a pointer to use for id-ing the track
                CheckBox selection = null;
                //traverse the gridview checking each row for a selection
                for (int i = 0; i < PlayList.Rows.Count; i++)
                {
                    //find checkbox
                    //playlist selection will point to the checkbox
                    selection = PlayList.Rows[i].FindControl("Selected") as CheckBox;
                    //is checked?
                    if (selection.Checked)
                    {
                        trackid = int.Parse((PlayList.Rows[i].FindControl("TrackId") as Label).Text);
                        tracknumber = int.Parse((PlayList.Rows[i].FindControl("TrackNumber") as Label).Text);
                        rowselect++;
                    }
                }
                if (rowselect != 1)
                {
                    MessageUserControl.ShowInfo("Bad", "Please select 1 (ONLY 1) Track to move");
                }
                else
                {
                    //check if on top
                    if (tracknumber == 1)
                    {
                        MessageUserControl.ShowInfo("wait a minute", "This track is already at the top of the playlist. Cannot raise track.");
                    }
                    else
                    {
                        //at this point, light is green. 
                        //got playlistname, username, trackid and tracknumber. all needed to move track
                        MoveTrack(trackid, tracknumber, "up");
                    }
                }
            }
        }
    }

    protected void MoveDown_Click(object sender, EventArgs e)
    {
        if (PlayList.Rows.Count == 0)
        {
            MessageUserControl.ShowInfo("BAD", "No playlist has been retrieved");

        }
        else
        {
            if (String.IsNullOrEmpty(PlaylistName.Text))
            {
                MessageUserControl.ShowInfo("bad", "no playlist name. gimee");
            }
            else
            {
                //check that one, and only one, row is selected
                int trackid = -1;
                int tracknumber = -1;
                int rowselect = 0;
                //create a pointer to use for id-ing the track
                CheckBox selection = null;
                //traverse the gridview checking each row for a selection
                for (int i = 0; i < PlayList.Rows.Count; i++)
                {
                    //find checkbox
                    selection = PlayList.Rows[i].FindControl("Selected") as CheckBox;
                    //is checked?
                    if (selection.Checked)
                    {
                        trackid = int.Parse((PlayList.Rows[i].FindControl("TrackId") as Label).Text);
                        tracknumber = int.Parse((PlayList.Rows[i].FindControl("TrackNumber") as Label).Text);
                        rowselect++;
                    }
                }
                if (rowselect != 1)
                {
                    MessageUserControl.ShowInfo("Bad", "Please select 1 (ONLY 1) Track to move");
                }
                else
                {
                    //check if on top
                    if (tracknumber == PlayList.Rows.Count)
                    {
                        MessageUserControl.ShowInfo("wait a minute", "This track is already at the bottom of the playlist. Cannot lower track.");
                    }
                    else
                    {

                        MoveTrack(trackid, tracknumber, "down");
                    }
                }
            }
        }

    }
    protected void MoveTrack(int trackid, int tracknumber, string direction)
    {
        //code to go here
        MessageUserControl.TryRun(() =>
        {
            //standrd call to bll method
            PlaylistTracksController sysmgr = new PlaylistTracksController();
            sysmgr.MoveTrack(User.Identity.Name, PlaylistName.Text, trackid, tracknumber, direction);
            //refresh list
            List<UserPlaylistTrack> results = sysmgr.List_TracksForPlaylist(PlaylistName.Text, User.Identity.Name);
            PlayList.DataSource = results;
            PlayList.DataBind();

        }, "Success", "The track moved");

    }
    protected void DeleteTrack_Click(object sender, EventArgs e)
    {
        if (PlayList.Rows.Count == 0)
        {
            MessageUserControl.ShowInfo("BAD", "No playlist has been retrieved");

        }
        else
        {
            if (String.IsNullOrEmpty(PlaylistName.Text))
            {
                MessageUserControl.ShowInfo("bad", "no playlist name. gimee");
            }
            else
            {
                //colelct the selecte tracks to delete
                //amke sure there are at least 1
                List<int> tracktodelete=new List<int>();
                int selectedrows = 0;
                CheckBox playlistselection = null;
                for (int i=0; i < PlayList.Rows.Count; i++)
                {
                    playlistselection = PlayList.Rows[i].FindControl("Selected") as CheckBox;
                    if (playlistselection.Checked)
                    {
                        tracktodelete.Add(int.Parse((PlayList.Rows[i].FindControl("TrackId") as Label).Text));
                        selectedrows++;
                    }
                }
               if (selectedrows == 0)
                {
                    MessageUserControl.ShowInfo("bad", "no track selected to delete");

                }
                else
                {
                    //you got what you need
                    //send to bll for processing
                    MessageUserControl.TryRun(() =>
                    {

                        PlaylistTracksController sysmgr = new PlaylistTracksController();
                        List<UserPlaylistTrack> playlistdata=sysmgr.DeleteTracks(User.Identity.Name, PlaylistName.Text, tracktodelete);
                        PlayList.DataSource = playlistdata;
                        PlayList.DataBind();
                    },"Removed", "Tracks have been removed from playlist");

                }
            }
        }


    }
}
