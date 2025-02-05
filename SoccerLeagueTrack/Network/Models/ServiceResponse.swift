enum ServiceResponse<T: Decodable> {
    case success(T)
    case error(ServiceResponseError)
}
