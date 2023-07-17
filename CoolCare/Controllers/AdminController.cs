using CoolCare.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CoolCareAdminpanel.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin
       
        public ActionResult DashBoard()
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

                if (Session["userid"] == null)
                {
                    return RedirectToAction("UserLogin");
                }
                else
                {

                    using (coolcareEntities3 db = new coolcareEntities3())
                    {
                        int usercount = db.Users.Count(m => m.UserTypeId == 3);  //user count
                        int technicount = db.Users.Count(m => m.UserTypeId == 2); //technician count
                        int countfeedback = db.Feedbacks.Count(); //user feedback count



                        ViewBag.usercount = usercount;
                        ViewBag.techniciancount = technicount;
                        ViewBag.feedbackcount = countfeedback;



                        var bookedServices = db.Bookservices.Include("Service").ToList().Join(db.Users, bs => bs.AssignedTechnician, t => t.UserId, (bs, t) => new { BookedService = bs, Technician = t })
                        .Select(x => x.BookedService).ToList();

                        var assignedTechnician = db.Bookservices.Join(db.Users, bs => bs.AssignedTechnician, t => t.UserId, (bs, t) => new { BookedService = bs, Technician = t })
                        .Select(x => x.Technician).ToList();



                        ServicePackage sp = new ServicePackage()
                        {
                            ServiceList = bookedServices,
                            userList = assignedTechnician
                        };


                        var TechnicianList = db.Users.Where(m => m.UserTypeId == 2).Select(x => new { x.UserId, x.FirstName }).ToList();

                        //passing technician list to dashboard
                        ViewBag.technicianList = TechnicianList;



                        return View(sp);
                    }  
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
        public ActionResult AssignTechnician(FormCollection formData, Bookservice b)
        {
            try
            {


                int serviceid = Convert.ToInt32(formData["ServiceId"]);
                int technicianId = Convert.ToInt32(formData["AssignedTechnician"]);

                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    db.AssignTechnician(serviceid, technicianId);
                    db.SaveChanges();

                    return RedirectToAction("DashBoard");

                }
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }

        public ActionResult UserDetail()
        {
            try
            {
                    using (coolcareEntities3 db = new coolcareEntities3())
                    {
                        var userList = db.Users.Where(m => m.UserTypeId == 3).ToList();
                        return View(userList);
                    }
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }


        public IList<User> GetUserList()
        {
            coolcareEntities3 db = new coolcareEntities3();
           
            var UserList = db.Users.Where(m => m.UserTypeId == 3).ToList().Select(m=> new User { 
                UserId=m.UserId,
                FirstName = m.FirstName,
                LastName = m.LastName,
                Address = m.Address,
                Email = m.Email,
                MobileNumber = m.MobileNumber
            }).ToList();
            return UserList;
        }

        [HttpPost]
        public ActionResult ExportToExcel()
        {
            var gv = new GridView();
            gv.DataSource = this.GetUserList();
            gv.DataBind();

            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=UserDetailsExcel.xls");
            Response.ContentType = "application/ms-excel";

            Response.Charset = "";
            StringWriter objStringWriter = new StringWriter();
            HtmlTextWriter objHtmlTextWriter = new HtmlTextWriter(objStringWriter);

            gv.RenderControl(objHtmlTextWriter);

            Response.Output.Write(objStringWriter.ToString());
            Response.Flush();
            Response.End();

            return View("Index");
        }

        public ActionResult BookedService()
        {
            try
            {
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    var list = db.Bookservices.ToList();

                    return View(list);
                }
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }

        public ActionResult Services()
        {
            try
            {
                    using (coolcareEntities3 db = new coolcareEntities3())
                    {
                        var serviceList = db.Services.ToList();
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

        

        public ActionResult Packages()
        {
            try
            {
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    var PackageList = db.Packages.Include("User").ToList();
                    return View(PackageList);

                }
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }

        public ActionResult Technician()
        {
            try
            {
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    var technicianList = db.Users.Where(m => m.UserTypeId == 2).ToList();

                    return View(technicianList);
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
        public ActionResult AddTechnician(FormCollection fmdata)
        {
            try
            {
                string temail =fmdata["techemail"];
                string tpass = fmdata["techpass"];
                User u = new User();
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                   //calling stored procedure
                    db.AddTechnician(temail, tpass, 2);
              
                    db.SaveChanges();

                    TempData["techaddmsg"] = "Technician Added Succesfully .";
                    return RedirectToAction("Technician","Admin");
                }
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }

        public ActionResult Feedback()
        {
            try
            {
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    var userFeedback = db.Feedbacks.ToList();
                    return View(userFeedback);
                }
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }
        public ActionResult MyProfile(int id)
        {
            try
            {
                User u;
                using (coolcareEntities3 db = new coolcareEntities3())
                {
                    u = db.Users.Find(id);
                    return View(u);
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
        public ActionResult MyProfile(User u)
        {
            try
            {
                using (coolcareEntities3 db = new coolcareEntities3())
                {

                    //calling stored procedure
                    db.EditProfileData(u.UserId, u.FirstName, u.LastName, u.MobileNumber,
                        u.Email, u.State, u.City, u.Address, u.Pincode);

                    db.SaveChanges();
                    return RedirectToAction("DashBoard","Admin");
                }
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