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
    }
}
