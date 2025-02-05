@testable import SoccerLeagueTrack
import XCTest

final class LeagueServiceTests: XCTestCase {

    private var sut: LeagueService!
    private var mockNetworkService: MockNetworkService!
    private var mockRequestBuilder: MockRequestBuilder!
    private var fakeURLString: String!

    override func setUp() {
        super.setUp()
        fakeURLString = "https://api.example.com"
        mockNetworkService = MockNetworkService()
        mockRequestBuilder = MockRequestBuilder()
        sut = LeagueService(networkService: mockNetworkService, baseURL: fakeURLString)
    }

    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        mockRequestBuilder = nil
        super.tearDown()
    }

    func testLeagueServiceTests_givenValidResponse_returnsTeamModels() async {
        // Given
        let rawTeamModel = RawTeamModel(idStanding: "1", intRank: "1", strTeam: "Team A")
        let tableResponse = TableResponse(table: [rawTeamModel])
        let validData = try! JSONEncoder().encode(tableResponse)

        mockNetworkService.stubbedResult = .success(validData)

        // When
        let result = await sut.getLookUpTable(leagueId: 1, season: "2023")

        // Then
        switch result {
        case .success(let teamModels):
            XCTAssertEqual(teamModels.count, 1, "The response should contain one team model.")
            XCTAssertEqual(teamModels.first?.strTeam, "Team A", "The team name should match the response data.")
        case .error:
            XCTFail("Expected success but received error.")
        }
    }

    func testLeagueServiceTests_givenNetworkError_returnsError() async {
        // Given
        let networkError = ServiceResponseError(errorType: .serverError)
        mockNetworkService.stubbedResult = .error(networkError)

        // When
        let result = await sut.getLookUpTable(leagueId: 1, season: "2023")

        // Then
        switch result {
        case .success:
            XCTFail("Expected error but received success.")
        case .error(let error):
            XCTAssertEqual(error.errorType, .serverError, "The error type should be `.serverError`.")
        }
    }

    func testLeagueServiceTests_givenInvalidData_returnsError() async {
        // Given
        let invalidData = "Invalid Data".data(using: .utf8)
        mockNetworkService.stubbedResult = .success(invalidData!)

        // When
        let result = await sut.getLookUpTable(leagueId: 1, season: "2023")

        // Then
        switch result {
        case .success:
            XCTFail("Expected error but received success.")
        case .error(let error):
            XCTAssertEqual(error.errorType, .decodingError, "The error type should be `.decodingError`.")
        }
    }
}
