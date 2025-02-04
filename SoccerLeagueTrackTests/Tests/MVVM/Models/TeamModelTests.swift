import XCTest
@testable import SoccerLeagueTrack

final class TeamModelTests: XCTestCase {
    // MARK: - Properties
    var jsonDecoder: JSONDecoder!
    var sut: TeamModel!
    
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
    
    func testTeamModel_givenValidRawModel_returnsValidTeamModel() {
        // Given
        let data = RawTeamModelTestData.validJSONData
        let rawModel = try? jsonDecoder.decode(RawTeamModel.self, from: data)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let expectedDate = dateFormatter.date(from: "2021-06-17 23:00:11")
        
        // When
        guard let rawModel else {
            XCTFail("Failed to decode `RawTeamModel` from JSON data."); return
        }
        sut = TeamModel(from: rawModel)

        // Then
        XCTAssertEqual(sut.idStanding, 1, "The `idStanding` should be converted to an integer value.")
        XCTAssertEqual(sut.intRank, 2, "The `intRank` should be converted to an integer value.")
        XCTAssertEqual(sut.idTeam, 101, "The `idTeam` should be converted to an integer value.")
        XCTAssertEqual(sut.strTeam, "Test Team", "The `strTeam` should match the raw model's value.")
        XCTAssertEqual(sut.strBadge?.absoluteString, "https://example.com/badge.png", "The `strBadge` URL should be correctly formed.")
        XCTAssertEqual(sut.dateUpdated, expectedDate, "The `dateUpdated` should be correctly converted to a date.")
        
        if let url = sut.strBadge {
            XCTAssertNotNil(url.scheme, "The URL should have a valid scheme, so it should be considered valid.")
        } else {
            XCTAssertNotNil(sut.strBadge, "The conversion should not return nil.")
        }
    }

    func testTeamModel_givenMissingFieldsInJSON_returnsModelWithNilFields() {
        // Given
        let data = RawTeamModelTestData.partialJSONData
        let rawModel = try? jsonDecoder.decode(RawTeamModel.self, from: data)
        
        // When
        guard let rawModel else {
            XCTFail("Failed to decode `RawTeamModel` from JSON data."); return
        }
        
        sut = TeamModel(from: rawModel)

        // Then
        XCTAssertEqual(sut.idStanding, 1, "The `idStanding` should be converted to an integer value.")
        XCTAssertEqual(sut.strTeam, "Partial Team", "The `strTeam` should match the raw model's value.")
    }

    func testModel_givenEmptyJSON_returnsModelWithAllNilFields() {
        // Given
        let rawModel = RawTeamModel()

        // When
        let result = TeamModel(from: rawModel)

        // Then
        XCTAssertNil(result.idStanding, "The `idStanding` should be nil if the raw model is missing the field.")
        XCTAssertNil(result.strTeam, "The `strTeam` should be nil if the raw model is missing the field.")
        XCTAssertNil(result.intPoints, "The `intPoints` should be nil if the raw model is missing the field.")
    }

    func testModel_givenIntFieldInsteadOfString_returnsValidModel() {
        // Given
        let jsonData = RawTeamModelTestData.jsonWithIntsData
        let rawModel = try? jsonDecoder.decode(RawTeamModel.self, from: jsonData)
        
        // When & Then
        XCTAssertThrowsError(try jsonDecoder.decode(RawTeamModel.self, from: jsonData), "The decoder should throw an error for invalid JSON structure.")
    }
}
