@testable import SoccerLeagueTrack
import XCTest

final class NetworkServiceTests: XCTestCase {
    
    private var sut: NetworkService!
    private var mockRequestBuilder: MockRequestBuilder!
    private var mockResponseHandler: MockResponseHandler!
    private var mockURLSession: MockURLSession!
    private var fakeURLString: String!

    override func setUp() {
        super.setUp()
        fakeURLString = "https://api.example.com/test"
        mockRequestBuilder = MockRequestBuilder()
        mockResponseHandler = MockResponseHandler()
        mockURLSession = MockURLSession()
    }

    override func tearDown() {
        sut = nil
        mockRequestBuilder = nil
        mockResponseHandler = nil
        mockURLSession = nil
        fakeURLString = nil
        super.tearDown()
    }

    func testPerformRequest_givenValidTableResponse_whenDecodedSuccessfully_thenReturnsSuccess() async {
        // Given
        let endpoint = Endpoint(path: "/test", method: .GET, queryParams: nil)
        let rawTeamModel = RawTeamModel(idStanding: "1", intRank: "5", strTeam: "Team A")
        let responseModel = TableResponse(table: [rawTeamModel])
        let validData = try! JSONEncoder().encode(responseModel)

        mockRequestBuilder.setURLRequest(with: fakeURLString)
        mockURLSession.buildSuccessSession(with: validData)
        
        sut = NetworkService(
            requestBuilder: mockRequestBuilder,
            session: mockURLSession)

        // When
        let result: ServiceResponse<TableResponse> = await sut.performRequest(for: endpoint, decodingType: TableResponse.self)

        // Then
        switch result {
        case .success(let response):
            XCTAssertEqual(response.table.count, 1, "The response should contain one team.")
            XCTAssertEqual(response.table.first?.strTeam, "Team A", "The team name should match the response data.")
            XCTAssertEqual(response.table.first?.intRank, "5", "The rank should match the response data.")
        case .error:
            XCTFail("Expected success but received error.")
        }
    }

    func testPerformRequest_givenErrorResponse_whenHandled_thenReturnsError() async {
        // Given
        let endpoint = Endpoint(path: "/test", method: .GET, queryParams: nil)
        let networkError = ServiceResponseError(errorType: .serverError)

        mockRequestBuilder.setURLRequest(with: fakeURLString)
        mockResponseHandler.stubbedResult = .failure(networkError)
        
        sut = NetworkService(
            requestBuilder: mockRequestBuilder,
            responseHandler: mockResponseHandler,
            session: mockURLSession)

        // When
        let result: ServiceResponse<TableResponse> = await sut.performRequest(for: endpoint, decodingType: TableResponse.self)

        // Then
        switch result {
        case .success:
            XCTFail("Expected error but received success.")
        case .error(let error):
            XCTAssertEqual(error.errorType, .unknown, "The error type should be `.serverError`.")
        }
    }

    func testPerformRequest_givenInvalidData_whenDecodingFails_thenReturnsError() async {
        // Given
        let endpoint = Endpoint(path: "/test", method: .GET, queryParams: nil)
        let invalidData = "Invalid Data".data(using: .utf8)

        mockRequestBuilder.setURLRequest(with: fakeURLString)
        mockURLSession.buildSuccessSession(with: invalidData)

        sut = NetworkService(
            requestBuilder: mockRequestBuilder,
            responseHandler: mockResponseHandler,
            session: mockURLSession)
        
        // When
        let result: ServiceResponse<TableResponse> = await sut.performRequest(for: endpoint, decodingType: TableResponse.self)

        // Then
        switch result {
        case .success:
            XCTFail("Expected error but received success.")
        case .error(let error):
            XCTAssertEqual(error.errorType, .unknown, "The error type should be `.unknown` when decoding fails.")
        }
    }
}
