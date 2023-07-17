using CoolCare.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;

namespace CoolCare.Controllers
{
    public class ForgetController : Controller
    {
        [NonAction]
        public void SendVerificationLinkEmail(string emailID, string activationCode, string emailFor = "VerifyAccount")
        {
            try
            {
                var verifyUrl = "/Forget/" + emailFor + "/" + activationCode;
                TempData["link"] = verifyUrl;

                var link = Request.Url.AbsoluteUri.Replace(Request.Url.PathAndQuery, verifyUrl);

                var fromEmail = new MailAddress("m2i8h0i8r@gmail.com", "CoolCare");
                var toEmail = new MailAddress(emailID);
                var fromEmailPassword = "armzpfamfldgqlty"; // Replace with actual password

                string subject = "";
                string body = "";
                if (emailFor == "VerifyAccount")
                {
                    subject = "Your account is successfully created!";
                    body = "<br/><br/>We are excited to tell you that your Dotnet Awesome account is" +
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

        //Part 3 - Forgot Password

        public ActionResult ForgotPassword()
        {
            
                return View();
        }

        [HttpPost]
        public ActionResult ForgotPassword(FormCollection fm)
        {
            try
            {
                string EmailID = fm["Email"];
                string message = "";
            

                using (coolcareEntities3 dc = new coolcareEntities3())
                {
                    var account = dc.Users.Where(a => a.Email == EmailID).FirstOrDefault();
                    if (account != null)
                    {
                        //Send email for reset password
                        string resetCode = Guid.NewGuid().ToString();
                        SendVerificationLinkEmail(account.Email, resetCode, "ResetPassword");
                        account.ResetPasswordCode = resetCode;

                        //This line I have added here to avoid confirm password not match issue , as we had added a confirm password property 
                        //in our model class in part 1
                        dc.Configuration.ValidateOnSaveEnabled = false;
                        dc.SaveChanges();
                        message = "Reset password link has been sent to your email id. " + EmailID;
                    }
                    else
                    {
                        message = "Account not found";
                    }
                }
                ViewBag.Message = message;
                return View("ResetLink");
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }

        public ActionResult ResetLink()
        {
            return View();
        }

        public ActionResult ResetPassword(string id)
        {
            //Verify the reset password link
            //Find account associated with this link
            //redirect to reset password page

            try
            {
                if (string.IsNullOrWhiteSpace(id))
                {
                    return HttpNotFound();
                }

                using (coolcareEntities3 dc = new coolcareEntities3())
                {
                    var user = dc.Users.Where(a => a.ResetPasswordCode == id).FirstOrDefault();
                    if (user != null)
                    {
                        ResetPasswordModel model = new ResetPasswordModel();
                        model.ResetCode = id;
                        return View(model);
                    }
                    else
                    {
                        return HttpNotFound();
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
        [ValidateAntiForgeryToken]
        public ActionResult ResetPassword(ResetPasswordModel model)
        {
            try
            {
                var message = "";
                if (ModelState.IsValid)
                {
                    using (coolcareEntities3 dc = new coolcareEntities3())
                    {
                        var user = dc.Users.Where(a => a.ResetPasswordCode == model.ResetCode).FirstOrDefault();
                        if (user != null)
                        {
                            user.Password = model.NewPassword;
                            user.ResetPasswordCode = "";
                            dc.Configuration.ValidateOnSaveEnabled = false;
                            dc.SaveChanges();
                            message = "New password updated successfully";
                        }
                    }
                }
                else
                {
                    message = "Something invalid";
                }
                ViewBag.Message = message;
                return View(model);
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