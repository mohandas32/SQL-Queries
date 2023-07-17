//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CoolCare.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class GenerateReport
    {
        public int ReportId { get; set; }
        public System.DateTime BookTime { get; set; }
        public System.DateTime ServiceDate { get; set; }
        public string ServiceDescription { get; set; }
        public Nullable<int> CustomerId { get; set; }
        public Nullable<int> TechnicianId { get; set; }
        public Nullable<int> ServiceId { get; set; }
        public Nullable<bool> IsDeleted { get; set; }
        public Nullable<decimal> ServiceAmount { get; set; }
        public Nullable<System.DateTime> CreatedOn { get; set; }
        public Nullable<System.DateTime> UpdatedOn { get; set; }
    
        public virtual Bookservice Bookservice { get; set; }
        public virtual Bookservice Bookservice1 { get; set; }
        public virtual User User { get; set; }
        public virtual User User1 { get; set; }
        public virtual User User2 { get; set; }
        public virtual User User3 { get; set; }
    }
}