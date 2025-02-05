@testable import SoccerLeagueTrack
import XCTest

final class ErrorNetworkTypeTests: XCTestCase {

    func testErrorNetworkType_givenErrorNetworkType_returnsCorrectCode() {
        // Given - When - Then
        XCTAssertEqual(ErrorNetworkType.invalidResponse.statusCode, 400, "The status code for `invalidResponse` should be 400.")
        XCTAssertEqual(ErrorNetworkType.invalidURL.statusCode, -1000, "The status code for `invalidURL` should be -1000.")
        XCTAssertEqual(ErrorNetworkType.decodingError.statusCode, -1002, "The status code for `decodingError` should be -1002.")
        XCTAssertEqual(ErrorNetworkType.unauthorized.statusCode, 401, "The status code for `unauthorized` should be 401.")
        XCTAssertEqual(ErrorNetworkType.timeout.statusCode, 408, "The status code for `timeout` should be 408.")
        XCTAssertEqual(ErrorNetworkType.invalidRequest.statusCode, 400, "The status code for `invalidRequest` should be 400.")
        XCTAssertEqual(ErrorNetworkType.notFound.statusCode, 404, "The status code for `notFound` should be 404.")
        XCTAssertEqual(ErrorNetworkType.serverError.statusCode, 500, "The status code for `serverError` should be 500.")
        XCTAssertEqual(ErrorNetworkType.emptyContent.statusCode, 204, "The status code for `emptyContent` should be 204.")
        XCTAssertEqual(ErrorNetworkType.unknown.statusCode, -1, "The status code for `unknown` should be -1.")
    }

    func testErrorNetworkType_givenErrorNetworkType_returnsCorrectDetail() {
        // Given - When - Then
        XCTAssertEqual(ErrorNetworkType.invalidResponse.detail, "The response was invalid.", "The detail message for `invalidResponse` should be correct.")
        XCTAssertEqual(ErrorNetworkType.invalidURL.detail, "The URL provided was invalid.", "The detail message for `invalidURL` should be correct.")
        XCTAssertEqual(ErrorNetworkType.decodingError.detail, "Failed to decode the response.", "The detail message for `decodingError` should be correct.")
        XCTAssertEqual(ErrorNetworkType.unauthorized.detail, "You are not authorized to access this resource.", "The detail message for `unauthorized` should be correct.")
        XCTAssertEqual(ErrorNetworkType.timeout.detail, "The request timed out.", "The detail message for `timeout` should be correct.")
        XCTAssertEqual(ErrorNetworkType.invalidRequest.detail, "The request was invalid.", "The detail message for `invalidRequest` should be correct.")
        XCTAssertEqual(ErrorNetworkType.notFound.detail, "The requested resource was not found.", "The detail message for `notFound` should be correct.")
        XCTAssertEqual(ErrorNetworkType.serverError.detail, "The server encountered an error.", "The detail message for `serverError` should be correct.")
        XCTAssertEqual(ErrorNetworkType.emptyContent.detail, "The response doesn't have content.", "The detail message for `emptyContent` should be correct.")
        XCTAssertEqual(ErrorNetworkType.unknown.detail, "An unknown error occurred.", "The detail message for `unknown` should be correct.")
    }
}
