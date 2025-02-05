import Foundation

class ResponseHandler {
    private let errorMapper: ErrorMapperProtocol

    init(errorMapper: ErrorMapperProtocol = ErrorRequestMapper()) {
        self.errorMapper = errorMapper
    }

    func handleResponse(_ data: Data?, _ response: URLResponse) -> Result<Data, ServiceResponseError> {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(ServiceResponseError(errorType: .invalidResponse, errorResponse: nil))
        }

        if (200...299).contains(httpResponse.statusCode), let validData = data, !validData.isEmpty {
            return .success(validData)
        }

        if let networkError = errorMapper.map(statusCode: httpResponse.statusCode) {
            return .failure(ServiceResponseError(networkError, content: data))
        }

        return .failure(ServiceResponseError(errorType:.emptyContent))
    }
}
