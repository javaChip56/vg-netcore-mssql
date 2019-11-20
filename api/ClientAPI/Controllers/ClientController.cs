using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using ClientAPI.Domain.Models;
using ClientAPI.Domain.Queries.Interfaces;

namespace ClientAPI.Controllers
{
    // [Route("api/[controller]")]
    [Route("endpoint/[action]")]
    [ApiController]
    public class ClientController : ControllerBase
    {
        private IClientQueries _clientQueries;
        public ClientController(IClientQueries clientQueries)
        {
            this._clientQueries = clientQueries;
        }

        [HttpGet]
        public async Task<Client> GetClient(int id)
        {
            return await this._clientQueries.GetClientAsync(id);
        }

        [HttpGet]
        public async Task<Client> GetClientByNo(string clientNo)
        {
            return await this._clientQueries.GetClientAsync(clientNo);
        }

        [HttpGet]
        public async Task<IEnumerable<Client>> ListAll()
        {
            return await this._clientQueries.GetAllClientsAsync();
        }
        
        [HttpPost]
        public async Task<bool> CreateClient(Client client)
        {
            return await this._clientQueries.InsertClientAsync(client);
        }
     
        [HttpPost]
        public async Task<bool> UpdateClient(Client client)
        {
            return await this._clientQueries.UpdateClientAsync(client);
        }

        [HttpPost]
        public async Task<bool> DeleteClient(int clientId)
        {
            return await this._clientQueries.DeleteClientAsync(clientId);
        }

        [HttpPost]
        public async Task<bool> DeleteClientByNo(string clientNo)
        {
            return await this._clientQueries.DeleteClientByNoAsync(clientNo);
        }
    }
}