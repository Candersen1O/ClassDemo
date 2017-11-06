using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Chinook.Data.Entities;
using ChinookSystem.DAL;
using Chinook.Data.POCOs;
using System.ComponentModel;


namespace ChinookSystem.BLL
{
    [DataObject]
    public class artistcontroller
    {
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<Artist> Artist_List()
        {
            using (var context=new ChinookContext())
            {
                return context.Artists.ToList();
            }
        }


        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Artist> Artists_List()
        {
            using (var context = new ChinookContext())
            {
                return context.Artists.ToList();
            }
        }


        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<SelectionList> List_ArtistNames()
        {
            using (var context = new ChinookContext())
            {
                var results = from x in context.Artists
                              orderby x.Name
                              select new SelectionList
                              {
                                  IDValueField = x.ArtistId,
                                  DisplayText = x.Name
                              };
                return results.ToList();
            }
        }
    }
}
