using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Data.SqlClient;

using Dapper;
using Dapper.Contrib;
using Dapper.Contrib.Extensions;

using ClientAPI.Domain.Models;
using ClientAPI.Domain.Queries.Interfaces;

namespace ClientAPI.Domain.Queries
{
    public class ClientQueries : IClientQueries
    {
        private string _connectionString = string.Empty;
        private SqlConnection _conn = null; 
        public ClientQueries(string connString)
        {
            this._connectionString = connString;
        }
        public async Task<Client> GetClientAsync(int id)
        {
            using (_conn = new SqlConnection(_connectionString))
            {
                _conn.Open();
                var parameters = new DynamicParameters();
                string query = @"SELECT CL.* from client CL WHERE CL.id=@pClientId";
                
                parameters.Add("pClientId", id);
                
                return await _conn.QueryFirstOrDefaultAsync<Client>(query, param: parameters); 
            }
        }
        public async Task<Client> GetClientAsync(string clientNo)
        {
            using (_conn = new SqlConnection(_connectionString))
            {
                _conn.Open();
                var parameters = new DynamicParameters();
                string query = @"SELECT CL.* from client CL WHERE CL.clientno=@pClientNo";
                
                parameters.Add("pClientNo", clientNo);

                return await _conn.QueryFirstOrDefaultAsync<Client>(query, param: parameters);
            }
        }
        public async Task<IEnumerable<Client>> GetAllClientsAsync()
        {
            using (_conn = new SqlConnection(_connectionString))
            {
                _conn.Open();
                string query = @"SELECT CL.* from client CL";

                return await _conn.QueryAsync<Client>(query);
            }
        }
        public async Task<bool> InsertClientAsync(Client client)
        {
            bool result = false;

            using (_conn = new SqlConnection(_connectionString))
            {
                _conn.Open();
                result = await _conn.InsertAsync<Client>(client) > 0;
            }

            return result;
        }
        public async Task<bool> UpdateClientAsync(Client client)
        {
            bool result = false;

            using (_conn = new SqlConnection(_connectionString))
            {
                _conn.Open();
                
                var uClient = _conn.Get<Client>(client.Id);
                
                if (uClient != null)
                    result = await _conn.UpdateAsync<Client>(client);
            }

            return result;
        }
        public async Task<bool> DeleteClientAsync(int Id)
        {
            bool result = false;

            using (_conn = new SqlConnection(_connectionString))
            {
                _conn.Open();
                
                var uClient = _conn.Get<Client>(Id);
                
                if (uClient != null)
                    result = await _conn.DeleteAsync<Client>(uClient);
            }

            return result;
        }
        public async Task<bool> DeleteClientByNoAsync(string clientNo)
        {
            bool result = false;

            using (_conn = new SqlConnection(_connectionString))
            {
                _conn.Open();
                string query = @"SELECT CL.* from client CL WHERE CL.clientno=@pClientNo";
                
                var parameters = new DynamicParameters();
                parameters.Add("pClientNo", clientNo);

                var uClient = _conn.QueryFirstOrDefault<Client>(query, param: parameters);
                
                if (uClient != null)
                    result = await _conn.DeleteAsync<Client>(uClient);
            }

            return result;
        }
    }
}
