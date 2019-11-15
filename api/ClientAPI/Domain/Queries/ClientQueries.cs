using System.Collections.Generic;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Dapper;

using ClientAPI.Domain.Models;
using ClientAPI.Domain.Queries.Interfaces;

namespace ClientAPI.Domain.Queries
{
    public class ClientQueries : IClientQueries
    {
        private string _connectionString = string.Empty;
        public ClientQueries(string connString)
        {
            this._connectionString = connString;
        }
        public async Task<Client> GetClientAsync(int id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                var parameters = new DynamicParameters();
                string query = @"SELECT CL.* from client CL WHERE CL.id=@pClientId";
                
                parameters.Add("pClientId", id);
                
                return await conn.QueryFirstOrDefaultAsync<Client>(query, param: parameters); 
            }
        }
        public async Task<Client> GetClientAsync(string clientNo)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                var parameters = new DynamicParameters();
                string query = @"SELECT CL.* from client CL WHERE CL.clientno=@pClientNo";
                
                parameters.Add("pClientNo", clientNo);

                return await conn.QueryFirstOrDefaultAsync<Client>(query, param: parameters);
            }
        }
        public async Task<IEnumerable<Client>> GetAllClientsAsync()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = @"SELECT CL.* from client CL";

                return await conn.QueryAsync<Client>(query);
            }
        }
        public async Task<IEnumerable<ClientAccount>> GetClientAccountsAsync(string clientNo)
        {
             using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                string query = @"SELECT CA.* from clientaccount CA";

                if (!string.IsNullOrEmpty(clientNo))
                {
                    var parameters = new DynamicParameters();
                    query += " WHERE CA.clientno=@pClientNo";
                    parameters.Add("pClientNo", clientNo);

                    return await conn.QueryAsync<ClientAccount>(query, param: parameters);
                }
                else
                {
                    return await conn.QueryAsync<ClientAccount>(query);
                }

            }
        }
    }
}
