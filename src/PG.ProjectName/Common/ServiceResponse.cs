namespace PG.ProjectName.Common
{
    public record ServiceResponse<T>
    {
        public bool IsSuccess { get; set; }
        public T? Data { get; set; }
        public string? Message { get; set; }

        public static ServiceResponse<T> Success(T data)
        {
            return new ServiceResponse<T>
            {
                IsSuccess = true,
                Data = data,
                Message = null,

            };
        }

        public static ServiceResponse<T> Failure(string message)
        {
            return new ServiceResponse<T>
            {
                IsSuccess = false,
                Data = default,
                Message = message

            };
        }

    }


}
