@testable import SoccerLeagueTrack
import XCTest

final class ErrorRequestMapperTests: XCTestCase {
    private var sut: ErrorRequestMapper!

    override func setUp() {
        super.setUp()
        sut = ErrorRequestMapper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testErrorRequestMapper_givenStatusCode200_returnsNil() {
        // Given
        let statusCode = 200

        // When
        let result = sut.map(statusCode: statusCode)

        // Then
        XCTAssertNil(result, "The result should be nil for a successful status code.")
    }

    func testErrorRequestMapper_givenStatusCode404_returnsCorrectError() {
        // Given
        let statusCode = 404

        // When
        let result = sut.map(statusCode: statusCode)

        // Then
        XCTAssertEqual(result, .notFound, "The result should be `.notFound` for status code 404.")
    }

    func testErrorRequestMapper_givenStatusCode500_returnsServerError() {
        // Given
        let statusCode = 500

        // When
        let result = sut.map(statusCode: statusCode)

        // Then
        XCTAssertEqual(result, .serverError, "The result should be `.serverError` for a 5xx status code.")
    }

    func testErrorRequestMapper_givenStatusCode302_returnsUnknownError() {
        // Given
        let statusCode = 302

        // When
        let result = sut.map(statusCode: statusCode)

        // Then
        XCTAssertEqual(result, .unknown, "The result should be `.unknown` for an undefined status code.")
    }

    func testErrorRequestMapper_givenStatusCode1001_returnsTimeoutError() {
        // Given
        let statusCode = -1001

        // When
        let result = sut.map(statusCode: statusCode)

        // Then
        XCTAssertEqual(result, .timeout, "The result should be `.timeout` for custom status code -1001.")
    }
}
