namespace PG.ProjectName.Services.Interfaces
{
    public interface IValidationService
    {
        Task<Dictionary<string, string>> GetAllValidations();
    }
}
