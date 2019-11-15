using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace ClientAPI
{
    public class Program
    {
        private static string _environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");

        public static void Main(string[] args)
        {
            CreateWebHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
            .UseKestrel(options => {
                if (!string.IsNullOrEmpty(_environment) && _environment.ToLower().Equals("development")) {
                    options.Listen(IPAddress.Loopback, 8080);
                } else {
                    options.Listen(IPAddress.Any, 8080);
                }
            })
            .UseStartup<Startup>();
    }
}
