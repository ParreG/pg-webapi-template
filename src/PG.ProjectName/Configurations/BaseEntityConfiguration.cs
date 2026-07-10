using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PG.ProjectName.Models;

namespace PG.ProjectName.Configurations
{
    public class BaseEntityConfiguration : IEntityTypeConfiguration<BaseEntity>
    {
        public void Configure(EntityTypeBuilder<BaseEntity> builder)
        {
            builder.HasKey(i => i.Id);
            builder.Property(i => i.CreatedAt).IsRequired();
            builder.Property(i => i.UpdatedAt).IsRequired();
        }
    }
}
