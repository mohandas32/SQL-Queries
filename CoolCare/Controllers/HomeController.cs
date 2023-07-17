using CoolCare.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.SessionState;

namespace CoolCare.Controllers
{

    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            try
            {
                if (TempData["showAlert"] != null && (bool)TempData["showAlert"])
                {
                    ViewBag.showAlert = true;
                }
                else
                {
                    ViewBag.showAlert = false;
                }
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    ViewBag.usercount = db.Users.Count(m => m.UserTypeId == 3);  //user count
                    ViewBag.techniciancount = db.Users.Count(m => m.UserTypeId == 2); //technician count
                    ViewBag.feedbackcount = db.Feedbacks.Count(); //user feedback count

                    var ServiceList = db.Services.ToList();
                    Class1 cl = new Class1();
                    cl.Services = ServiceList;
                    return View(cl);
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
        public ActionResult UserFeedback(FormCollection formData)
        {
            try
            {
                string feedbackContent = formData["feedback"];

                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    //calling stored procedure
                    db.InsertFeedback(feedbackContent, Convert.ToInt32(Session["userid"]));
                    db.SaveChanges();
                    
                }
                TempData["userfeedbackmsg"] = "Feedback Submitted Succesfully";


                return RedirectToAction("UserProfile");
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }


        [HttpPost]
        public ActionResult ContactUs(Class1 c1)
        {
            try
            {
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    db.ContactUs.Add(c1.ContactU);
                    db.SaveChanges();
                
                }
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }


        public ActionResult Admin()
        {
            return View();
        }

        public ActionResult Technician()
        {
            return View();
        }
        public ActionResult BookService()
        {
            try
            {
                Bookservice s = new Bookservice();

                coolcareEntities3 db = new coolcareEntities3();
          
                s.serviceList = db.Services.ToList();
                return View(s);
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }
        public ActionResult TechWorkDoneReport()
        {
            

            return View();
        }
        public ActionResult BookAMC()
        {
            

            return View();
        }

        [HttpPost]
        public ActionResult BookAMC(FormCollection fmData)
        {
            try
            {
                TempData["userid"] = Convert.ToInt32(Session["userid"]);
                TempData["acType"] = fmData["UnitType"];
                TempData["acCapacity"] = fmData["UnitCapacity"];
                TempData["packageType"] = fmData["Payment"];
                decimal amount = Convert.ToDecimal(fmData["Amount"]);
                Session["payamount"] = amount;

                return RedirectToAction("InitiatePayment", "Payment");
            }
            catch(Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }

        public ActionResult UserProfile()
        {
            try
            {
            var id = (int)Session["userid"];
            using (coolcareEntities3 db = new coolcareEntities3())
                {
                    var serviceList = db.Bookservices.Include("User").Include("Service").Where(m => m.UserId == id).ToList();
                    var packageList = db.Packages.Include("User").Where(m => m.UserId == id).ToList();
                    User userList = db.Users.Where(m => m.UserId == id).FirstOrDefault();

                    ServicePackage sp = new ServicePackage()
                    {
                        ServiceList = serviceList,
                        PackageList = packageList,
                        user = userList
                    };

                    return View(sp);
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
        public ActionResult UserProfile(FormCollection formData)
        {
            try
            {
                string fname = formData["user.FirstName"];
                string lname = formData["user.LastName"];
                string email = formData["user.Email"];
                string mobileno = formData["user.MobileNumber"];
                string address = formData["user.Address"];
                string city = formData["user.City"];
                string state = formData["user.State"];
                string pincode = formData["user.Pincode"];

                using(coolcareEntities3 db = new coolcareEntities3())
                {
                    //calling procedure
                    db.EditProfileData(Convert.ToInt32(Session["userid"]), fname, lname, mobileno, email, state, city, address, pincode);
                    db.SaveChanges();
                }

                TempData["updateprofilemsg"] = "Your Profile Updated Succesfully";
                return RedirectToAction("UserProfile");
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