import XCTest
@testable import SoccerLeagueTrack

final class RawTeamModelTests: XCTestCase {
    // MARK: - Properties
    var jsonDecoder: JSONDecoder!
    var sut: RawTeamModel!

    // MARK: - Lifecycle methods
    
    override func setUp() {
        super.setUp()
        jsonDecoder = JSONDecoder()
    }

    override func tearDown() {
        jsonDecoder = nil
        sut = nil
        super.tearDown()
    }

    func testRawTeam_givenValidJSON_returnsRawTeamModel() {
        // Given
        let data = RawTeamModelTestData.validJSONData

        // When
        sut = try? jsonDecoder.decode(RawTeamModel.self, from: data)

        // Then
        XCTAssertNotNil(sut, "The model should be successfully decoded from valid JSON.")
        XCTAssertEqual(sut?.idStanding, "1", "The `idStanding` should be '1'.")
        XCTAssertEqual(sut?.strTeam, "Test Team", "The `strTeam` should be 'Test Team'.")
        XCTAssertEqual(sut?.intGoalsFor, "20", "The `intGoalsFor` should be '20'.")
    }

    func testRawTeam_givenMissingFieldsInJSON_returnsModelWithNilFields() {
        // Given
        let data = RawTeamModelTestData.partialJSONData

        // When
        sut = try? jsonDecoder.decode(RawTeamModel.self, from: data)

        // Then
        XCTAssertNotNil(sut, "The model should be decoded even if some fields are missing.")
        XCTAssertEqual(sut?.idStanding, "1", "The `idStanding` should be '1'.")
        XCTAssertNil(sut?.intWin, "The `intWin` field should be nil since it's missing in the JSON.")
    }

    func testRawTeam_givenInvalidJSON_throwsError() {
        // Given
        let data = RawTeamModelTestData.invalidJSONData

        // When & Then
        XCTAssertThrowsError(try jsonDecoder.decode(RawTeamModel.self, from: data), "The decoder should throw an error for invalid JSON structure.")
    }

    func testRawTeam_givenEmptyJSON_returnsModelWithAllNilFields() {
        // Given
        let data = RawTeamModelTestData.emptyJSONData

        // When
        sut = try? jsonDecoder.decode(RawTeamModel.self, from: data)

        // Then
        XCTAssertNotNil(sut, "The model should be successfully decoded from an empty JSON.")
        XCTAssertNil(sut?.idStanding, "The `idStanding` field should be nil for an empty JSON.")
        XCTAssertNil(sut?.intGoalsFor, "The `intGoalsFor` field should be nil for an empty JSON.")
    }

    func testRawTeam_givenIntFieldInsteadOfString_returnsNilModel() {
        // Given
        let jsonData = RawTeamModelTestData.jsonWithIntsData

        // When
        sut = try? jsonDecoder.decode(RawTeamModel.self, from: jsonData)

        // Then
        XCTAssertNil(sut, "The model should not be decoded because there are some fields are integers.")
    }

    func testRawTeam_givenBooleanFieldInsteadOfString_returnsNil() {
        // Given
        let jsonData = RawTeamModelTestData.jsonWithBooleanData

        // When
        sut = try? jsonDecoder.decode(RawTeamModel.self, from: jsonData)

        // Then
        XCTAssertNil(sut, "The model should be nil because cannot handle boolean fields gracefully.")
    }

    func testRawTeam_givenInvalidDateField_returnsNil() {
        // Given
        let jsonData = RawTeamModelTestData.jsonWithIncorrectDate

        // When
        sut = try? jsonDecoder.decode(RawTeamModel.self, from: jsonData)

        // Then
        XCTAssertNil(sut, "The model should be nil because can't decode with an invalid date field.")
    }

    func testRawTeam_givenValidDateInString_returnsDateAsString() {
        // Given
        let jsonData = RawTeamModelTestData.jsonWithCorrecDate

        // When
        sut = try? jsonDecoder.decode(RawTeamModel.self, from: jsonData)

        // Then
        XCTAssertNotNil(sut, "The model should decode with a valid date string.")
        XCTAssertEqual(sut?.dateUpdated, "2023-01-30", "The `dateUpdated` field should be '2023-01-30'.")
    }
}
