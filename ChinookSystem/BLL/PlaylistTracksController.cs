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
                                    TrackID =x.TrackId,
                                    TrackNumber =x.TrackNumber,
                                    TrackName =x.Track.Name,
                                    Milliseconds=x.Track.Milliseconds,
                                    UnitPrice=x.Track.UnitPrice
                                };

                return thetracks.ToList();
            }
        }//eom
        public void Add_TrackToPLaylist(string playlistname, string username, int trackid)
        {
            using (var context = new ChinookContext())
            {
                //code to go here
                
             
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
