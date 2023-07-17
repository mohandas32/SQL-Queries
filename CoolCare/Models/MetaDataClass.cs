using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;


namespace CoolCare.Models
{
    //public class MetaDataClass
    //{
    [MetadataType(typeof(Metadata))]
    public partial class User
    {
        [Required(ErrorMessage ="Enter Conform Password")]
        //[Compare("Password", ErrorMessage ="Must be same as password")]
        [DataType(DataType.Password)]
        public string CnfPassword { get; set; }


        //list of all technician
        public List<User> TechnicianList { get; set; }

        internal class Metadata
        {
            public int UserId { get; set; }

            [Required(ErrorMessage = "*Please Enter field")]
            [RegularExpression("^[A-Za-z]+$", ErrorMessage = "Only alphabets allowed")]

            public string FirstName { get; set; }
            [RegularExpression("^[A-Za-z]+$", ErrorMessage = "Only alphabets allowed")]

            [Required(ErrorMessage = "Please Enter field")]
            public string LastName { get; set; }
            [Required(ErrorMessage = "Please Enter field")]
            [RegularExpression("[6789][0-9]{9}", ErrorMessage = "Phone Number Required in Valid Format")]

            public string MobileNumber { get; set; }


            [Required(ErrorMessage = "Please Enter field")]
            [RegularExpression(@"^[A-Za-z0-9_\.]+@+[A-Za-z]+\.+[A-Za-z]{2,}$", ErrorMessage = "EmailId Required in Valid Format")]
            public string Email { get; set; }



            [Required(ErrorMessage = "Please Enter field")]
            //[StringLength(15, MinimumLength = 6, ErrorMessage ="Password length should be between 6 to 15")]
            //[RegularExpression(@"^[A-Za-z0-9]+$", ErrorMessage = "Only alphabets and number allowed")]
            [DataType(DataType.Password)]
            public string Password { get; set; }



            [Required(ErrorMessage = "Please Enter field")]
            public string State { get; set; }


            [Required(ErrorMessage = "Please Enter field")]
            public string City { get; set; }


            [Required(ErrorMessage = "Please Enter field")]
            public string Address { get; set; }

            [Required(ErrorMessage = "Please Enter field")]
            [RegularExpression(@"^[0-9]{6}$", ErrorMessage = "Only 6 digit allowed")]
            public string Pincode { get; set; }
        }
    }

    [MetadataType(typeof(Metadata))]
    public partial class Service
    {
        internal class Metadata
        {
            public int Id { get; set; }
            public string ServiceName { get; set; }
            public string ServiceDescription { get; set; }
            public Nullable<bool> isDeleted { get; set; }
            public string Price { get; set; }

        }
    }

    [MetadataType(typeof(Metadata))]
    public partial class ContactU
    {
        internal class Metadata
        {
            public int id { get; set; }

            [Required(ErrorMessage = "Please Enter field")]
            public string Name { get; set; }


            [Required(ErrorMessage = "Please Enter field")]
            [RegularExpression("[6789][0-9]{9}", ErrorMessage = "Phone Number Required in Valid Format")]
            public string PhoneNo { get; set; }


            [Required(ErrorMessage = "Please Enter field")]
            [RegularExpression(@"^[A-Za-z0-9_\.]+@+[A-Za-z]+\.+[A-Za-z]{2,}$", ErrorMessage = "EmailId Required in Valid Format")]
            public string Email { get; set; }


            [Required(ErrorMessage = "Please Enter field")]
            public string Message { get; set; }

        }
    }


    [MetadataType(typeof(Metadata))]
    public partial class Bookservice
    {
        public List<Service> serviceList { get; set; }

        internal class Metadata
        {

            public int ServiceId { get; set; }
            
            [Required(ErrorMessage ="Please Enter Address")]
            public string Address { get; set; }
            public string NumberOfAC { get; set; }
            public string TypesOfAC { get; set; }
            public string TypesOfService { get; set; }

        }
    }

    [MetadataType(typeof(Metadata))]
    public partial class Package
    {
 
        internal class Metadata
        {
            public string TypeOfPackage { get; set; }

            public string ACType { get; set; }
            public string ACCapacity { get; set; }

            public decimal Amount { get; set; }

        }
    }

    [MetadataType(typeof(Metadata))]
    public partial class Payment
    {

        internal class Metadata
        {
            public int PaymentId { get; set; }
            public string PaymentType { get; set; }
            public decimal Amount { get; set; }

        }
    }

    [MetadataType(typeof(Metadata))]
    public partial class GenerateReport
    {
        internal class Metadata
        {

            public string ServiceDescription { get; set; }
      

        }
    }

}