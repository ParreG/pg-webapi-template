using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PG.ProjectName.Services.Interfaces;

namespace PG.ProjectName.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValidationController : ControllerBase
    {
        private readonly IValidationService _validationService;

        public ValidationController(IValidationService validationService)
        {
            _validationService = validationService;
        }

        [HttpGet]
        public async Task<ActionResult<Dictionary<string, string>>> GetValidations()
        {
            var validations = await _validationService.GetAllValidations();
            return Ok(validations);
        }
    }
}
