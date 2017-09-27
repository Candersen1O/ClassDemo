using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Chinook.Data.Entities;
using ChinookSystem.DAL;
using Chinook.Data.POCOs;
using System.ComponentModel;
using Chinook.Data.DTOs;

namespace ChinookSystem.BLL
{
    [DataObject]
    public class GenreController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<GenreDTO> ListAlbumsbyGenre()
        {
            using (var context = new ChinookContext())
            {
                var results = from x in context.Genres
                              select new GenreDTO
                              {//Genre DTO
                                  genre = x.Name,
                                  albums = from y in x.Tracks
                                           group y by y.Album into gresults
                                           select new AlbumDTO//Album DTO
                                           {
                                               title = gresults.Key.Title,
                                               year = gresults.Key.ReleaseYear,
                                               //numotracks=gresults.Key.Tracks.Count(),
                                               numotracks = gresults.Count(),
                                               tracks = from z in gresults
                                                        select new TrackPOCO
                                                        {//track POCO
                                                            song = z.Name,
                                                            length = z.Milliseconds
                                                        }
                                           }
                              };

                return results.ToList();
            }
        }
    }
}
