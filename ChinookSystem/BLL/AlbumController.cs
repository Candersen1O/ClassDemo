using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region addon namespace
using Chinook.Data.Entities;
using ChinookSystem.DAL;
using Chinook.Data.POCOs;
using System.ComponentModel;
#endregion

namespace ChinookSystem.BLL
{

   [DataObject]
    public class AlbumController
    {
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<artistalbumspocobyreleaseyear> Albums_ByArtist(int artistid)
        {
            using (var context = new ChinookContext())
            {
                var results = from x in context.Albums
                              where x.ArtistId.Equals(artistid)
                              select new artistalbumspocobyreleaseyear
                              {
                                  Title = x.Title,
                                  Released = x.ReleaseYear
                              };
                return results.ToList();
            }
        }

        //return albums between year x and y
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<Album> Albums_FindInYears(int minyear, int maxyear)
        {
            using (var context=new ChinookContext())
            {
                var results= from alb in context.Albums
                             where alb.ReleaseYear > minyear && alb.ReleaseYear < maxyear
                             orderby alb.ReleaseYear, alb.Title
                             select alb;
                return results.ToList();
            }
        }
    }
}
