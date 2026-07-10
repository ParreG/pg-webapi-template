using Microsoft.Extensions.DependencyInjection.Extensions;
using PG.ProjectName.Services;
using PG.ProjectName.Services.Interfaces;

namespace PG.ProjectName.Configurations
{
    public static class DependencyInjections
    {
        public static IServiceCollection ServiceCollection(this IServiceCollection services)
        {
            services.AddScoped<IValidationService, ValidationService>();
            //services.AddSingleton();
            //services.TryAddTransient();

            return services;
        }
    }
}
