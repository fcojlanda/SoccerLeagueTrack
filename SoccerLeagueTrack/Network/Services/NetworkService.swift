import Foundation

actor NetworkService {
    private let responseHandler: ResponseHandler
    private let requestBuilder: RequestBuilder
    
    init(requestBuilder: RequestBuilder, responseHandler: ResponseHandler = ResponseHandler()) {
        self.requestBuilder = requestBuilder
        self.responseHandler = responseHandler
    }
    
    func performRequest<T: Decodable>(
        for endpoint: Endpoint,
        decodingType: T.Type
    ) async -> ServiceResponse<T> {
        do {
            let request = try requestBuilder.buildRequest(for: endpoint)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            switch responseHandler.handleResponse(data, response) {
            case .success(let validData):
                let successModel = try JSONDecoder().decode(decodingType, from: validData)
                return .success(successModel)
            case .failure(let networkError):
                return .error(networkError)
            }
        } catch {
            return .error(ServiceResponseError(errorType: .unknown))
        }
    }
}
