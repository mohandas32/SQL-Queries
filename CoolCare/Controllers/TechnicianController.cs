using CoolCare.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CoolCareAdminpanel.Controllers
{
    public class TechnicianController : Controller
    {
       
        public ActionResult ViewAssignedWork()
        {
            try
            {
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    int techId = Convert.ToInt32(Session["userid"]);
                    var serviceList = db.Bookservices.Include("Service").Include("User").Where(m => m.AssignedTechnician == techId).ToList();
                    return View(serviceList);
                }
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }

        public ActionResult TechWorkDoneReport(int serviceid, int customerid)
        {
            ViewBag.serviceid = serviceid;
            ViewBag.customerid = customerid;
            ViewBag.technicianid = Session["userid"];
            return View();
        }

        [HttpPost]
        public ActionResult TechWorkDoneReport(FormCollection fmData)
        {

            return RedirectToAction("DashBoard", "Admin");
        }


    }
}