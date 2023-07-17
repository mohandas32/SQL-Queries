using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CoolCare.Models;
using Razorpay.Api;

namespace CoolCare.Controllers
{
    public class PaymentController : Controller
    {

        public ActionResult InitiatePayment()
        {
            try
            {
               
                var key = ConfigurationManager.AppSettings["RazorPaykey"].ToString();
                var secret = ConfigurationManager.AppSettings["RazorPaySecret"].ToString();
                RazorpayClient client = new RazorpayClient(key, secret);
                Dictionary<string, object> options = new Dictionary<string, object>();
                options.Add("amount", Convert.ToDecimal(Session["payamount"]) * 100);
                options.Add("currency", "INR");
                Order order = client.Order.Create(options);
                ViewBag.orderId = order["id"].ToString();
                return View("Payment");
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
        }


        public ActionResult Payment(string razorpay_payment_id, string razorpay_order_id, string razorpay_signature)
        {
            try
            {
                Dictionary<string, string> attributes = new Dictionary<string, string>();
                attributes.Add("razorpay_payment_id", razorpay_payment_id);
                attributes.Add("razorpay_order_id", razorpay_order_id);
                attributes.Add("razorpay_signature", razorpay_signature);
                try
                {

                    Utils.verifyPaymentSignature(attributes);

                    using(coolcareEntities3 db = new coolcareEntities3())
                    {
                        //getting all the values
                        int customerid = Convert.ToInt32(TempData["userid"]);
                        string packagetype = Convert.ToString(TempData["packageType"]);
                        string actype = Convert.ToString(TempData["acType"]);
                        string accapacity = Convert.ToString(TempData["acCapacity"]);
                        decimal amount = Convert.ToDecimal(Session["payamount"]);

                        //calling stored procedure
                        db.AddPackageDetails(customerid, packagetype, amount, actype , accapacity );
                        db.SaveChanges();
                    }
                    TempData["bookamcmsg"] = "Your AMC Package Booked Succesfully";
                    return RedirectToAction("Index", "Home");

                }
                catch (Exception ex)
                {
                    return RedirectToAction("PaymentFailure", "Payment");
                }
            }
            catch (Exception ex)
            {
                //passing exception message to the error view
                ViewBag.ErrorMsg = ex.Message;
                return View("Error");
            }
            //return View();
        }

        public ActionResult PaymentSuccess()
        {
            return View();
        }

        public ActionResult PaymentFailure()
        {
            return View();
        }


    }
}