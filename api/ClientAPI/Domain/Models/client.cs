using System;

namespace ClientAPI.Domain.Models
{
    public class Client
    {
        public int Id { get; set; } 
        public string ClientName { get; set; } 
        public string ClientNo { get; set; } 
        public DateTime? BirthDate { get; set; } 
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; } 
        public string UpdatedBy { get; set; } 
        public DateTime? UpdatedDate { get; set; }
    }
}