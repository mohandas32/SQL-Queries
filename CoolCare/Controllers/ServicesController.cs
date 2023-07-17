using CoolCare.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CoolCare.Controllers
{
    public class ServicesController : Controller
    {
        // GET: Services
        [HttpPost]
        public ActionResult AddServices(FormCollection formdata)
        {
            try
            {
                string name = formdata["servicename"];
                string desc = formdata["servicedesc"];
                decimal price = Convert.ToDecimal(formdata["price"]);
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    db.AddServices(name, desc, price);
                    db.SaveChanges();

                    TempData["serviceaddmsg"] = "Service Added Successfully";

                    return RedirectToAction("Services", "Admin");

                }
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }

        public ActionResult DeleteService(Service s)
        {
            try
            {
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    Service userobj = db.Services.Where(m => m.Id == s.Id).FirstOrDefault();

                    db.Services.Remove(userobj);
                    db.SaveChanges();

                    TempData["servicedeletemsg"] = "Service Deleted Successfully";
                    return RedirectToAction("Services", "Admin");
                }
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }

        [HttpPost]
        public ActionResult Bookservice(FormCollection formData)
        {
            try
            {
                string address = formData["Address"];
                string numberofac = formData["NumberOfAC"];
                string typeofac = formData["TypeOfAC"];
                int typeofservice = Convert.ToInt32(formData["TypeOfService"]);

                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    //var lis = db.Services.Where(s => s.Id == typeofservice).Select(m => m.ServiceName).ToList();
                    db.BookService(address, numberofac, typeofac, typeofservice, Convert.ToInt32(Session["userid"]));
                    db.SaveChanges();
                }
                TempData["bookservicemsg"] = "Service Booked Succesfully";
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }
    }
}