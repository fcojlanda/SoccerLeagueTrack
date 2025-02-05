import XCTest
@testable import SoccerLeagueTrack

@MainActor
final class LeagueViewModelTests: XCTestCase {
    private var sut: LeagueViewModel!
    private var mockLeagueService: MockLeagueService!

    override func setUp() {
        super.setUp()
        mockLeagueService = MockLeagueService()
        sut = LeagueViewModel(leagueService: mockLeagueService)
    }

    override func tearDown() {
        sut = nil
        mockLeagueService = nil
        super.tearDown()
    }

    func testLeagueViewModel_givenSuccessResponse_updatesTeams() async {
        // Given
        mockLeagueService.buildServiceWithSuccessResponse()

        // When
        await sut.fetchLookUpTable(leagueId: 1, season: "2023")

        // Then
        XCTAssertFalse(sut.isLoading, "The loading state should be false after fetching data.")
        XCTAssertNil(sut.errorMessage, "The error message should be nil on success.")
        XCTAssertEqual(sut.teams.count, 1, "The teams array should contain one team.")
        XCTAssertEqual(sut.teams.first?.strTeam, "Test Team", "The team name should match the stubbed response.")
    }

    func testLeagueViewModel_givenErrorResponse_updatesErrorMessage() async {
        // Given
        mockLeagueService.buildServiceWithFailureResponse()

        // When
        await sut.fetchLookUpTable(leagueId: 1, season: "2023")

        // Then
        XCTAssertFalse(sut.isLoading, "The loading state should be false after fetching data.")
        XCTAssertEqual(sut.errorMessage, "Test error message", "The error message should match the stubbed error response.")
        XCTAssertTrue(sut.teams.isEmpty, "The teams array should be empty on error.")
    }

    func testLeagueViewModel_givenUnknownErrorResponse_updatesErrorMessage() async {
        // Given
        mockLeagueService.buildServiceWithUnknownResponse()

        // When
        await sut.fetchLookUpTable(leagueId: 1, season: "2023")

        // Then
        XCTAssertFalse(sut.isLoading, "The loading state should be false after fetching data.")
        XCTAssertEqual(sut.errorMessage, "An unknown error occurred.", "The error message should match the error type detail.")
        XCTAssertTrue(sut.teams.isEmpty, "The teams array should be empty on error.")
    }
}
