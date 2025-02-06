@testable import SoccerLeagueTrack
import XCTest

final class ServiceResponseErrorTests: XCTestCase {
    private var sut: ServiceResponseError!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testServiceResponseError_givenValidErrorResponseData_setsErrorResponse() {
        // Given
        let errorResponseData = RawTeamModelTestData.errorResponseData
        
        // When
        sut = ServiceResponseError(.invalidRequest, content: errorResponseData)

        // Then
        XCTAssertEqual(sut.errorType, .invalidRequest, "The error type should be `invalidRequest`.")
        XCTAssertNotNil(sut.errorResponse, "The error response should be decoded successfully from valid data.")
        XCTAssertEqual(sut.errorResponse?.message, "An error occurred", "The message in the error response should match.")
        XCTAssertEqual(sut.errorResponse?.status, 400, "The code in the error response should match.")
    }

    func testServiceResponseError_givenNilData_errorResponseIsNil() {
        // Given
        let errorData: Data? = nil

        // When
        sut = ServiceResponseError(.notFound, content: errorData)

        // Then
        XCTAssertEqual(sut.errorType, .notFound, "The error type should be `notFound`.")
        XCTAssertNil(sut.errorResponse, "The error response should be nil when no data is provided.")
    }

    func testServiceResponseError_givenInvalidData_errorResponseIsNil() {
        // Given
        let invalidData = "Invalid data".data(using: .utf8)

        // When
        sut = ServiceResponseError(.decodingError, content: invalidData)

        // Then
        XCTAssertEqual(sut.errorType, .decodingError, "The error type should be `decodingError`.")
        XCTAssertNil(sut.errorResponse, "The error response should be nil when the data cannot be decoded.")
    }

    func testServiceResponseError_givenManualErrorResponse_setsErrorResponse() {
        // Given
        let errorResponse = ErrorResponse(status: 500, message: "Manual error")

        // When
        sut = ServiceResponseError(errorType: .serverError, errorResponse: errorResponse)

        // Then
        XCTAssertEqual(sut.errorType, .serverError, "The error type should be `serverError`.")
        XCTAssertNotNil(sut.errorResponse, "The error response should be manually set.")
        XCTAssertEqual(sut.errorResponse?.message, "Manual error", "The message in the error response should match.")
        XCTAssertEqual(sut.errorResponse?.status, 500, "The code in the error response should match.")
    }
}
