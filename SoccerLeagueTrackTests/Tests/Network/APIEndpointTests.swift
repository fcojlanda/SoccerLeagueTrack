@testable import SoccerLeagueTrack
import XCTest

final class APIEndpointTests: XCTestCase {
    // MARK: - Properties
    var sut: Endpoint!
    
    // MARK: - Lifecycle methods
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAPIEndpoint_givenValidParameters_returnsCorrectEndpoint() {
        // Given
        let leagueId = 1234
        let season = "2023-2024"

        // When
        sut = APIEndpoint.lookUpTable(leagueId: leagueId, season: season)

        // Then
        XCTAssertEqual(sut.path, "api/v1/json/3/lookuptable.php", "The endpoint path should be correct.")
        XCTAssertEqual(sut.method, .GET, "The HTTP method should be GET.")
        XCTAssertEqual(sut.queryParams?["l"], "\(leagueId)", "The leagueId query parameter should be correctly set.")
        XCTAssertEqual(sut.queryParams?["s"], season, "The season query parameter should be correctly set.")
    }

    func testAPIEndpoint_givenEmptySeason_returnsCorrectEndpoint() {
        // Given
        let leagueId = 5678
        let season = ""

        // When
        sut = APIEndpoint.lookUpTable(leagueId: leagueId, season: season)

        // Then
        XCTAssertEqual(sut.path, "api/v1/json/3/lookuptable.php", "The endpoint path should be correct.")
        XCTAssertEqual(sut.method, .GET, "The HTTP method should be GET.")
        XCTAssertEqual(sut.queryParams?["l"], "\(leagueId)", "The leagueId query parameter should be correctly set.")
        XCTAssertEqual(sut.queryParams?["s"], season, "The season query parameter should allow empty values.")
    }

    func testAPIEndpoint_givenNegativeLeagueId_returnsCorrectEndpoint() {
        // Given
        let leagueId = -1
        let season = "2022-2023"

        // When
        sut = APIEndpoint.lookUpTable(leagueId: leagueId, season: season)

        // Then
        XCTAssertEqual(sut.path, "api/v1/json/3/lookuptable.php", "The endpoint path should be correct.")
        XCTAssertEqual(sut.method, .GET, "The HTTP method should be GET.")
        XCTAssertEqual(sut.queryParams?["l"], "\(leagueId)", "The leagueId query parameter should handle negative values.")
        XCTAssertEqual(sut.queryParams?["s"], season, "The season query parameter should be correctly set.")
    }
}
