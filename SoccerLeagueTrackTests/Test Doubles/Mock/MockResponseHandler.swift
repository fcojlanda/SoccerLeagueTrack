@testable import SoccerLeagueTrack
import Foundation

class MockResponseHandler: ResponseHandler {
    var stubbedResult: Result<Data, ServiceResponseError>?

    override func handleResponse(_ data: Data?, _ response: URLResponse) -> Result<Data, ServiceResponseError> {
        return stubbedResult ?? .failure(ServiceResponseError(errorType: .unknown))
    }
}
