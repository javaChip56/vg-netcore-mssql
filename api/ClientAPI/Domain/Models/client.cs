using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ClientAPI.Domain.Models
{
    [Table("Client")]
    public class Client
    {
        [Key]
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