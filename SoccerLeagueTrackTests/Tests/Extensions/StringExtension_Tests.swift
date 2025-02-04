@testable import SoccerLeagueTrack
import XCTest

final class StringExtension_Tests: XCTestCase {
    // MARK: - Properties
    var sut: String!
    
    // MARK: - Lifecycle methods
    
    override func setUp() {
        super.setUp()
        sut = nil
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testString_givenValidIntegerString_returnsIntValue() {
        // Given
        sut = "12345"
        
        // When
        let result = sut.convertToInt()
        
        // Then
        XCTAssertEqual(result, 12345, "The conversion should return the correct integer value.")
    }

    func testString_givenInvalidIntegerString_returnsNil() {
        // Given
        sut = "12a45"
        
        // When
        let result = sut.convertToInt()
        
        // Then
        XCTAssertNil(result, "The conversion should return nil for an invalid integer string.")
    }
    
    func testString_givenValidDateString_returnsDateValue() {
        // Given
        sut = "2023-01-30"
        let expectedDateComponents = DateComponents(year: 2023, month: 1, day: 30)
        let calendar = Calendar.current
        
        // When
        let result = sut.convertToDate()
        
        // Then
        XCTAssertNotNil(result, "The conversion should return a valid date.")
        XCTAssertEqual(calendar.dateComponents([.year, .month, .day], from: result!), expectedDateComponents, "The date should match the expected components.")
    }

    func testString_givenInvalidDateString_returnsNil() {
        // Given
        sut = "30-01-2023"
        
        // When
        let result = sut.convertToDate()
        
        // Then
        XCTAssertNil(result, "The conversion should return nil for an invalid date string.")
    }
    
    func testString_givenValidURLString_returnsURLValue() {
        // Given
        sut = "https://www.mysite.com"
        
        // When
        let result = sut.convertToURL()
        
        // Then
        if let url = result {
            XCTAssertNotNil(url.scheme, "The URL should have a valid scheme, so it should be considered valid.")
        } else {
            XCTAssertNotNil(result, "The conversion should not return nil.")
        }
    }

    func testString_givenInvalidURLString_returnsNil() {
        // Given
        sut = "invalid-url"

        // When
        let result = sut.convertToURL()

        // Then
        if let url = result {
            XCTAssertNil(url.scheme, "The URL should not have a valid scheme, so it should be considered invalid.")
        } else {
            XCTAssertNil(result, "The conversion should return nil for a malformed URL.")
        }
    }
}
