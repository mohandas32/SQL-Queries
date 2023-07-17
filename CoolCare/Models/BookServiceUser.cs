using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CoolCare.Models
{
    public class BookServiceUser
    {
        public List<User> technicianList { get; set; }
        public List<Bookservice> bookserviceList { get; set; }
    }
}