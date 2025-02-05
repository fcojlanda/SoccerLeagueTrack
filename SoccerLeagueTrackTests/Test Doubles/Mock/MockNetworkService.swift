@testable import SoccerLeagueTrack
import XCTest

class MockNetworkService: NetworkServicing {
    var responseHandler: ResponseHandling
    var requestBuilder: RequestBuilding
    var session: URLSessionProtocol
    var stubbedResult: ServiceResponse<Data>?

    init(responseHandler: ResponseHandling = MockResponseHandler(),
         requestBuilder: RequestBuilding = MockRequestBuilder(),
         session: URLSessionProtocol = MockURLSession()) {
        self.responseHandler = responseHandler
        self.requestBuilder = requestBuilder
        self.session = session
    }

    func performRequest<T: Decodable>(for endpoint: Endpoint, decodingType: T.Type) async -> ServiceResponse<T> {
        guard let result = stubbedResult else {
            return .error(ServiceResponseError(errorType: .unknown))
        }

        switch result {
        case .success(let data):
            do {
                let decodedData = try JSONDecoder().decode(decodingType, from: data)
                return .success(decodedData)
            } catch {
                return .error(ServiceResponseError(errorType: .decodingError))
            }
        case .error(let error):
            return .error(error)
        }
    }
}
