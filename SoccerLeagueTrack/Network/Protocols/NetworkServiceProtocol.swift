import Foundation

protocol NetworkServiceProtocol {
    func performRequest<T: Decodable>(for endpoint: Endpoint, decodingType: T.Type) async -> ServiceResponse<T>
}
