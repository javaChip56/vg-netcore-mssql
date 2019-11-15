using System;
using System.Threading;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace Diagnostics.HealthChecks
{
    public class DatabaseConnectionHealthCheck : IHealthCheck
    {
        private string _connectionString = string.Empty;
        public DatabaseConnectionHealthCheck(string conenctionString)
        {
            _connectionString = conenctionString;
        }

        public async Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext context, CancellationToken cancellationToken = new CancellationToken()) 
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                try
                {
                    await conn.OpenAsync(cancellationToken);
                } 
                catch (SqlException ex)
                {
                    return await Task.FromResult(new HealthCheckResult(status: context.Registration.FailureStatus, exception: ex));
                }
            }
            
            return await Task.FromResult(HealthCheckResult.Healthy("Client Database is Healthy."));
        }
    }
}
