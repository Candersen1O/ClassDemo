using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chinook.Data.POCOs
{
    public class TrackPOCO
    {
        public string song { get; set; }
        public int length { get; set; }
        public string LENGTH
        {
            get
            {
                int minutes = length / 60000;
                int seconds = (length % 60000) / 1000;
                return string.Format("{0}:{1:00}", minutes, seconds);
            }
        }
    }
}
