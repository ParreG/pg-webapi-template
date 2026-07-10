using PG.ProjectName.Services;
using Xunit;

namespace PG.ProjectName.Tests
{
    public class ValidationServiceTests
    {
        [Fact]
        public async Task GetAllValidations()
        {
            var service = new ValidationService();
            var result = await service.GetAllValidations();
            Assert.NotEmpty(result);
            Assert.NotNull(result);
            Assert.True(result.ContainsKey("Error_NotFound"));
        }
    }
}
