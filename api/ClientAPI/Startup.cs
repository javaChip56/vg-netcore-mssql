using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json.Serialization;
using Swashbuckle.AspNetCore.Swagger;
using HealthChecks.UI.Client;

using ClientAPI.Domain.Queries;
using ClientAPI.Domain.Queries.Interfaces;
namespace ClientAPI
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_2);
            services.AddMvc()
                .AddJsonOptions(options =>
                options.SerializerSettings.ContractResolver = new DefaultContractResolver());

            services.AddTransient<IClientQueries>(sp => new ClientQueries(Configuration["ConnectionStrings:ClientDB"]));

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc(
                    Configuration["SwaggerConfig:FriendlyName"] + Configuration["SwaggerConfig:Version"],
                    new Info { 
                        Title = Configuration["SwaggerConfig:Title"], 
                        Version = Configuration["SwaggerConfig:Version"] }
                        );
            });

            services.AddHealthChecks()
                .AddCheck("Client Database", new Diagnostics.HealthChecks.DatabaseConnectionHealthCheck(Configuration["ConnectionStrings:ClientDB"]));
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
                app.UseHttpsRedirection();
            }

            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint(
                    string.Format(
                        Configuration["SwaggerConfig:Endpoint"],
                        Configuration["SwaggerConfig:FriendlyName"] + Configuration["SwaggerConfig:Version"]), 
                        Configuration["SwaggerConfig:Title"] + " " + Configuration["SwaggerConfig:Version"]);
            });

            app.UseHealthChecks(path: "/hc", new HealthCheckOptions() {
                Predicate = _ => true,
                ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
            });
            app.UseMvc();

        }
    }
}
