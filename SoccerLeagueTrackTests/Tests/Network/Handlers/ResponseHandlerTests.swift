@testable import SoccerLeagueTrack
import XCTest

final class ResponseHandlerTests: XCTestCase {
    private var sut: ResponseHandler!
    private var mockErrorMapper: MockErrorMapper!

    override func setUp() {
        super.setUp()
        mockErrorMapper = MockErrorMapper()
        sut = ResponseHandler(errorMapper: mockErrorMapper)
    }

    override func tearDown() {
        sut = nil
        mockErrorMapper = nil
        super.tearDown()
    }

    func testResponseHandler_givenValidResponseWithData_returnsSuccess() {
        // Given
        let validData = "Valid response".data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        let result = sut.handleResponse(validData, response!)

        // Then
        switch result {
        case .success(let data):
            XCTAssertEqual(data, validData, "The returned data should match the valid response data.")
        case .failure:
            XCTFail("Expected success but received failure.")
        }
    }

    func testResponseHandler_givenNilData_returnsFailure() {
        // Given
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        let result = sut.handleResponse(nil, response!)

        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but received success.")
        case .failure(let error):
            XCTAssertEqual(error.errorType, .emptyContent, "The error type should be `.emptyContent` for nil or empty data.")
        }
    }

    func testResponseHandler_givenInvalidHTTPResponse_returnsInvalidResponseError() {
        // Given
        let invalidResponse = URLResponse(url: URL(string: "https://example.com")!,
                                          mimeType: nil,
                                          expectedContentLength: 0,
                                          textEncodingName: nil)

        // When
        let result = sut.handleResponse(nil, invalidResponse)

        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but received success.")
        case .failure(let error):
            XCTAssertEqual(error.errorType, .invalidResponse, "The error type should be `.invalidResponse` for a non-HTTP response.")
        }
    }

    func testResponseHandler_givenErrorStatusCode_returnsMappedError() {
        // Given
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        mockErrorMapper.stubbedError = .notFound

        // When
        let result = sut.handleResponse(nil, response!)

        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but received success.")
        case .failure(let error):
            XCTAssertEqual(error.errorType, .notFound, "The error type should be `.notFound` for status code 404.")
        }
    }

    func testResponseHandler_givenUndefinedErrorStatusCode_returnsUnknownError() {
        // Given
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 302, httpVersion: nil, headerFields: nil)
        mockErrorMapper.stubbedError = .unknown

        // When
        let result = sut.handleResponse(nil, response!)

        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but received success.")
        case .failure(let error):
            XCTAssertEqual(error.errorType, .unknown, "The error type should be `.unknown` for an undefined status code.")
        }
    }
}
