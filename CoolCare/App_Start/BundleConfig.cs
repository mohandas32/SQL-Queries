using System.Web;
using System.Web.Optimization;

namespace CoolCare
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));


            bundles.Add(new ScriptBundle("~/bundles/script").Include(
            "~/Scripts/CoolCare/assets/vendor/purecounter/purecounter.js",
            "~/Scripts/CoolCare/assets/vendor/aos/aos.js",
            "~/Scripts/CoolCare/assets/vendor/bootstrap/js/bootstrap.bundle.min.js",
            "~/Scripts/CoolCare/assets/vendor/glightbox/js/glightbox.min.js",
            "~/Scripts/CoolCare/assets/vendor/isotope-layout/isotope.pkgd.min.js",
            "~/Scripts/CoolCare/main.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js"));

            //bundles.Add(new StyleBundle("~/Content/css").Include(
            //          "~/Content/bootstrap.css",
            //          "~/Content/site.css"));

            bundles.Add(new StyleBundle("~/Content/style").Include(

                       "~/Content/CoolCare/aos.css",
                         "~/Content/CoolCare/assets/vendor/bootstrap/css/bootstrap.min.css",
                           "~/Content/CoolCare/assets/vendor/bootstrap-icons/bootstrap-icons.css",
                             "~/Content/CoolCare/assets/vendor/glightbox/css/glightbox.min.css",
                               "~/Content/CoolCare/assets/vendor/swiper/swiper-bundle.min.css",
                                     "~/Content/CoolCare/style.css"));
        }
    }
}
