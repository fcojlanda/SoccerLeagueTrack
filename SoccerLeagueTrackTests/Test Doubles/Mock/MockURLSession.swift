@testable import SoccerLeagueTrack
import Foundation

class MockURLSession: URLSessionProtocol {
    var stubbedData: Data?
    var stubbedResponse: URLResponse?
    var stubbedError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = stubbedError {
            throw error
        }

        guard let data = stubbedData, let response = stubbedResponse else {
            throw URLError(.badServerResponse)
        }

        return (data, response)
    }
    
    func buildSuccessSession(with data: Data?) {
        stubbedData = data
        guard let fakeUrl = URL(string: "https://api.example.com") else {
            return
        }
        
        stubbedResponse = HTTPURLResponse(url: fakeUrl, statusCode: 200, httpVersion: nil, headerFields: nil)
    }
}
