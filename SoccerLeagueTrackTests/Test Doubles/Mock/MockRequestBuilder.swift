@testable import SoccerLeagueTrack
import Foundation

class MockRequestBuilder: RequestBuilding {
    var stubbedRequest: URLRequest?
    
    func buildRequest(for endpoint: Endpoint) throws -> URLRequest {
        guard let request = stubbedRequest else {
            throw ServiceResponseError(errorType: .invalidURL)
        }
        return request
    }
    
    func addHeaderStrategy(_ strategy: HeaderDecorator) {
        
    }
    
    func setURLRequest(with stringURL: String) {
        guard let url = URL(string: stringURL) else {
            return
        }
        stubbedRequest = URLRequest(url: url)
    }
}
