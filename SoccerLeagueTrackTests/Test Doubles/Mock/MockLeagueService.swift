@testable import SoccerLeagueTrack
import Foundation

class MockLeagueService: LeagueServicing {
    var networkService: NetworkServicing
    var errorMapper: ErrorMapping
    var stubbedResult: ServiceResponse<[TeamModel]>?
    
    private var jsonDecoder: JSONDecoder!

    init() {
        jsonDecoder = JSONDecoder()
        
        networkService = MockNetworkService()
        errorMapper = MockErrorMapper()
    }
    
    func getLookUpTable(leagueId: Int, season: String) async -> ServiceResponse<[TeamModel]> {
        return stubbedResult ?? .error(ServiceResponseError(errorType: .unknown))
    }
    
    func buildServiceWithSuccessResponse() {
        let data = RawTeamModelTestData.validJSONData
        let rawModel = try? jsonDecoder.decode(RawTeamModel.self, from: data)
        guard let rawModel else {
            return
        }
        
        let teamModel = TeamModel(from: rawModel)
        self.stubbedResult = .success([teamModel])
    }
    
    func buildServiceWithFailureResponse() {
        let errorResponse = ErrorResponse(
            status: 401, message: "Test error message")
        let serviceError = ServiceResponseError(errorType: .serverError, errorResponse: errorResponse)
        self.stubbedResult = .error(serviceError)
        
    }
    
    func buildServiceWithUnknownResponse() {
        let serviceError = ServiceResponseError(errorType: .unknown)
        self.stubbedResult = .error(serviceError)
    }
}
