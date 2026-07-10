using PG.ProjectName.Resources;
using PG.ProjectName.Services.Interfaces;
using System.Collections;
using System.Globalization;
using System.Resources;
namespace PG.ProjectName.Services
{
    public class ValidationService : IValidationService
    {
        public Task<Dictionary<string, string>> GetAllValidations()
        {
            ResourceManager resourceManager = new ResourceManager(typeof(Validations));

            var validations = resourceManager.GetResourceSet(CultureInfo.InvariantCulture, true, true);

            var dictionary = new Dictionary<string, string>();

            if (validations == null)
            {
                return Task.FromResult(dictionary);
            }

            foreach (DictionaryEntry entry in validations)
            {
                dictionary.Add(entry.Key?.ToString() ?? string.Empty, entry.Value?.ToString() ?? string.Empty);
            }

            return Task.FromResult(dictionary);
        }
    }


public static class ValidationServiceEndpoints
{
	public static void MapValidationServiceEndpoints (this IEndpointRouteBuilder routes)
    {
        var group = routes.MapGroup("/api/ValidationService").WithTags(nameof(ValidationService));

        group.MapGet("/", () =>
        {
            return new [] { new ValidationService() };
        })
        .WithName("GetAllValidationServices")
        .WithOpenApi();

        group.MapGet("/{id}", (int id) =>
        {
            //return new ValidationService { ID = id };
        })
        .WithName("GetValidationServiceById")
        .WithOpenApi();

        group.MapPut("/{id}", (int id, ValidationService input) =>
        {
            return TypedResults.NoContent();
        })
        .WithName("UpdateValidationService")
        .WithOpenApi();

        group.MapPost("/", (ValidationService model) =>
        {
            //return TypedResults.Created($"/api/ValidationServices/{model.ID}", model);
        })
        .WithName("CreateValidationService")
        .WithOpenApi();

        group.MapDelete("/{id}", (int id) =>
        {
            //return TypedResults.Ok(new ValidationService { ID = id });
        })
        .WithName("DeleteValidationService")
        .WithOpenApi();
    }
}}
