using CoolCare.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace CoolCare.Controllers
{
    public class LoginController : Controller
    {


        [NonAction]
        public bool IsEmailExist(string Email)
        {
            try
            {
                using (coolcareEntities3 dc = new coolcareEntities3())
                {
                    var v = dc.Users.Where(a => a.Email == Email).FirstOrDefault();
                    return v != null;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public ActionResult UserSignUp()
        {
            return View();
        }


        //Registration POST action 
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UserSignUp([Bind(Exclude = "IsEmailVerified,ActivationCode")] User user)
        {
            ViewBag.msg = null;
            try
            {
                bool Status = false;
                string message = "";
                //
                // Model Validation 
                if (ModelState.IsValid)
                {


                    var isExist = IsEmailExist(user.Email);
                    if (isExist)
                    {
                        ViewBag.errormsg = "Email already exist";
                        
                        return View(user);
                    }

                    user.ActivationCode = Guid.NewGuid();
                    user.Password = user.Password;
                    user.IsEmailVerified = false;

                    //Send Email to User
                    SendVerificationLinkEmail(user.Email, user.ActivationCode.ToString());
                    message = "Registration successfully done. Account activation link " +
                           " has been sent to your email id:" + user.Email;
                    Status = true;
                    using (coolcareEntities3 dc = new coolcareEntities3())
                    {
                        user.CreatedOn = DateTime.Now;
                        user.UserTypeId = 3;
                        user.IsDeleted = false;
                        dc.Users.Add(user);
                        dc.SaveChanges();
                    }

                }
                else
                {
                    message = "Invalid Request";
                }

                ViewBag.Message = message;
                ViewBag.Status = Status;
                ViewBag.msg = "An Email Verification Link Has Been Sent To Your Given Email.";
                return View("UserSignUp");
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }

      
        [HttpGet]
        public ActionResult VerifyAccount(string id)
        {
            try
            {
                bool Status = false;
                using (coolcareEntities3 dc = new coolcareEntities3())
                {
                    dc.Configuration.ValidateOnSaveEnabled = false; // This line I have added here to avoid 
                                                                    // Confirm password does not match issue on save changes
                    var v = dc.Users.Where(a => a.ActivationCode == new Guid(id)).FirstOrDefault();
                    if (v != null)
                    {
                        v.IsEmailVerified = true;
                        dc.SaveChanges();
                        Status = true;
                    }
                    else
                    {
                        ViewBag.Message = "Invalid Request";
                    }
                }
                ViewBag.Status = Status;
                return View();
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }




        [NonAction]
        public void SendVerificationLinkEmail(string emailID, string activationCode, string emailFor = "VerifyAccount")
        {
            try
            {
                var verifyUrl = "/Login/" + emailFor + "/" + activationCode;
                var link = Request.Url.AbsoluteUri.Replace(Request.Url.PathAndQuery, verifyUrl);

                var fromEmail = new MailAddress("m2i8h0i8r@gmail.com", "CoolCare");
                var toEmail = new MailAddress(emailID);
                var fromEmailPassword = "armzpfamfldgqlty"; // Replace with actual password

                string subject = "";
                string body = "";
                if (emailFor == "VerifyAccount")
                {
                    subject = "Your account is successfully created!";
                    body = "<br/><br/>We are excited to tell you that your Cool Care account is" +
                        " successfully created. Please click on the below link to verify your account" +
                        " <br/><br/><a href='" + link + "'>" + link + "</a> ";

                }
                else if (emailFor == "ResetPassword")
                {
                    subject = "Reset Password";
                    body = "Hi,<br/><br/>We got request for reset your account password. Please click on the below link to reset your password" +
                        "<br/><br/><a href=" + link + ">Reset Password link</a>";
                }


                var smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(fromEmail.Address, fromEmailPassword)
                };

                using (var message = new MailMessage(fromEmail, toEmail)
                {
                    Subject = subject,
                    Body = body,
                    IsBodyHtml = true
                })
                    smtp.Send(message);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public ActionResult UserLogin()
        {
            return View();
        }

        //Login POST
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(User userdata, string ReturnUrl = "")
        {
            try
            {
                string message = "";
                using (coolcareEntities3 dc = new coolcareEntities3())
                {
                    var v = dc.Users.Where(a => a.Email == userdata.Email).FirstOrDefault();
                    var PassExist = dc.Users.Any(m => m.Email == userdata.Email && m.Password == userdata.Password);
       

                    if(!PassExist)
                    {
                        TempData["loginerror"] = "Email or Password mismatch";
                    }
                    
                    if (v != null)
                    {
                        if ((bool)!v.IsEmailVerified)
                        {
                            TempData["Message"] = "Please verify your email first";
                            return View("UserLogin");
                        }


                        if (string.Compare(userdata.Password, v.Password) == 0)
                        {
                            Session["userName"] = (v.FirstName + " " + v.LastName).ToString();
                            Session["userid"] = v.UserId;
                            Session["email"] = v.Email;
                            Session["mobileno"] = v.MobileNumber;
                            Session["userTypeid"] = (int)v.UserTypeId;

                            TempData["showAlert"] = true;

                            if (v.UserTypeId == 1)
                            {
                                return RedirectToAction("DashBoard", "Admin");

                            }
                            else if (v.UserTypeId == 2)
                            {
                                return RedirectToAction("DashBoard", "Admin");

                            }
                            else
                            {
                                return RedirectToAction("Index","Home");
                            }

                        }
                        else
                        {
                            message = "Invalid credential provided";


                            if (TempData["showAlert"] != null && (bool)TempData["showAlert"])
                            {
                                ViewBag.showAlert = true;
                            }
                            else
                            {
                                ViewBag.showAlert = false;
                            }
                            return View("UserLogin");
                        }
                    }
                    else
                    {
                        message = "Invalid credential provided";
                    }
                }
                ViewBag.Message = message;
                return View("UserLogin");
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }


        public ActionResult Logout()
        {
            try
            {
                Session.Clear();
                return RedirectToAction("UserLogin");
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