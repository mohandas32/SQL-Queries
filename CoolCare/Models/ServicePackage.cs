using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CoolCare.Models
{
    public class ServicePackage
    {
        public List<Bookservice> ServiceList { get; set; }
        public List<Package> PackageList { get; set; }

        public User user { get; set; }

        public List<User> userList { get; set; }
    }
}