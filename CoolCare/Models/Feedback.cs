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
    
    public partial class Feedback
    {
        public string Feedback1 { get; set; }
        public Nullable<int> UserId { get; set; }
        public Nullable<bool> IsDeleted { get; set; }
        public Nullable<System.DateTime> CreatedOn { get; set; }
        public Nullable<System.DateTime> UpdatedOn { get; set; }
        public int fId { get; set; }
    
        public virtual User User { get; set; }
        public virtual User User1 { get; set; }
    }
}