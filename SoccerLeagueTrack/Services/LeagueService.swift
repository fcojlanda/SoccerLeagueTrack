import Foundation

class LeagueService: LeagueServicing {
    var networkService: NetworkServicing
    var errorMapper: ErrorMapperProtocol

    init(networkService: NetworkServicing? = nil, errorMapper: ErrorMapperProtocol = ErrorRequestMapper()) {
        let defaultHeader = ApplicationJSONHeaderStrategy()
        let requestBuilder = RequestBuilder(headerStrategies: [defaultHeader])
        
        if let networkService {
            self.networkService = networkService
        } else {
            let networkService  = NetworkService(
                requestBuilder: requestBuilder)
            
            self.networkService = networkService
        }
        
        self.errorMapper = errorMapper
    }

    func getLookUpTable(leagueId: Int, season: String) async -> ServiceResponse<[TeamModel]> {
        let endpoint = APIEndpoint.lookUpTable(leagueId: leagueId, season: season)
        let result = await networkService.performRequest(for: endpoint, decodingType: TableResponse.self)

        switch result {
        case .success(let tableResponse):
            let teamModels = tableResponse.table.map { TeamModel(from: $0) }
            return .success(teamModels)
        case .error(let error):
            return .error(error)
        }
    }
}
