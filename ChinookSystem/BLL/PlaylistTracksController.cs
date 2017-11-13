using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using Chinook.Data.Entities;
using Chinook.Data.DTOs;
using Chinook.Data.POCOs;
using ChinookSystem.DAL;
using System.ComponentModel;
#endregion

namespace ChinookSystem.BLL
{
    public class PlaylistTracksController
    {
        public List<UserPlaylistTrack> List_TracksForPlaylist(
            string playlistname, string username)
        {
            using (var context = new ChinookContext())
            {

                //code to go here
                //what if there is not match for the incoming parameters
                //we need to ensure that results have a valid value. The value will be an IEnumberable <T> colelction or null
                //to ensure that results does end up with a valid value use the  .FirstOrDefault()
                var results = (from x in context.Playlists
                               where x.UserName == username && x.Name.Equals(playlistname)
                               select x).FirstOrDefault();

                var thetracks = from x in context.PlaylistTracks
                                where x.PlaylistId == results.PlaylistId
                                orderby x.TrackNumber
                                select new UserPlaylistTrack
                                {
                                    TrackID = x.TrackId,
                                    TrackNumber = x.TrackNumber,
                                    TrackName = x.Track.Name,
                                    Milliseconds = x.Track.Milliseconds,
                                    UnitPrice = x.Track.UnitPrice //consider if the song was bought
                                };

                return thetracks.ToList();
            }
        }//eom
        public List<UserPlaylistTrack> Add_TrackToPLaylist(string playlistname, string username, int trackid)
        {
            using (var context = new ChinookContext())
            {
                //code to go here
                //create a new pkey value (parent)
                //create a child of the pkey. CAN'T PARENT DOESN'T EXIST YET
                //DO NOT ENTER A SAVE CHANGE AFTER PARENT CREATION, THIS CREaTES 2 TRANSACTIONS INSTEAD OF JUST 1
                //Playlist constructor uses HashSet, gives pseudo pkeys
                //
                //child creation uses navigation
                //SaveChange()

                // just do a query to determine playlist id
                var exists = (from x in context.Playlists
                              where x.UserName == username && x.Name.Equals(playlistname)
                              select x).FirstOrDefault();
                //initialize the tracknumber for the track going info playlist tracks
                int tracknumber = 0;
                //i will need to create an instance of PlaylistTrack
                PlaylistTrack newtrack = null;
                //determine if this is an addition or a creation and addition
                if (exists == null)
                {
                    exists = new Playlist();
                    exists.Name= playlistname;
                    exists.UserName = username;
                    exists = context.Playlists.Add(exists);
                    tracknumber = 1;
                }
                else
                {
                    //the playlist already exists
                    //need to know the number of tracks currently on the list
                    tracknumber = exists.PlaylistTracks.Count() + 1;
                    //playlist can only have a track once per playlist
                    newtrack = exists.PlaylistTracks.SingleOrDefault(x => x.TrackId==trackid);
                    //this will be null if the track is not in the playlist
                    if (newtrack != null)
                    {
                        throw new Exception("Playlist already has this track.");
                    }
                }
                //END OF PLAYLIST HANDLING
                //BEGIN HANDLING TRACK FOR PLAYLIST
                //use navigation to add the new track to the playlist
                newtrack = new PlaylistTrack();
                newtrack.TrackId = trackid;
                newtrack.TrackNumber = tracknumber;
                //NOTE the pkey for the playlistid may not exist yet. using navigation, one can let hashset handle the playlistid pkey
                //
                exists.PlaylistTracks.Add(newtrack);

                //physically commit your work to the database
                context.SaveChanges();
                return List_TracksForPlaylist(playlistname, username);

            }
        }//eom
        public void MoveTrack(string username, string playlistname, int trackid, int tracknumber, string direction)
        {
            using (var context = new ChinookContext())
            {
                //code to go here 

            }
        }//eom


        public void DeleteTracks(string username, string playlistname, List<int> trackstodelete)
        {
            using (var context = new ChinookContext())
            {
                //code to go here


            }
        }//eom
    }
}
