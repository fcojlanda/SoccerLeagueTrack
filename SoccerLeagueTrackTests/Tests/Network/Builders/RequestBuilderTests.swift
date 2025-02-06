import XCTest
@testable import SoccerLeagueTrack

final class RequestBuilderTests: XCTestCase {
    
    private var sut: RequestBuilder!

    override func setUp() {
        super.setUp()
        sut = RequestBuilder(stringURL: "https://api.example.com")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testRequestBuilder_givenValidEndpoint_requestIsCorrect() throws {
        // Given
        let endpoint = Endpoint(path: "/v1/test", method: .GET, queryParams: ["key": "value"])

        // When
        let request = try sut.buildRequest(for: endpoint)

        // Then
        XCTAssertEqual(request.url?.absoluteString, "https://api.example.com/v1/test?key=value", "The URL should be correctly constructed with query parameters.")
        XCTAssertEqual(request.httpMethod, "GET", "The HTTP method should be correctly set to GET.")
        XCTAssertNil(request.httpBody, "The HTTP body should be nil for a GET request.")
    }

    func testRequestBuilder_givenHeaderStrategy_headersAreSetCorrectly() throws {
        // Given
        let endpoint = Endpoint(path: "/v1/test", method: .POST, queryParams: nil)
        
        let defaultHeaders = ApplicationJSONHeaderStrategy()
        sut.addHeaderStrategy(defaultHeaders)

        // When
        let request = try sut.buildRequest(for: endpoint)

        // Then
        XCTAssertEqual(request.allHTTPHeaderFields?["Content-Type"], "application/json", "The Content-Type header should be correctly set by the strategy.")
        XCTAssertEqual(request.allHTTPHeaderFields?["Accept"], "application/json", "The Accept header should be correctly set by the strategy.")
    }
}
