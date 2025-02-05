import Foundation

class LeagueService {
    private let networkService: NetworkServicing
    private let requestBuilder: RequestBuilding
    private let errorMapper: ErrorMapperProtocol

    init(networkService: NetworkServicing,
         baseURL: String,
         errorMapper: ErrorMapperProtocol = ErrorRequestMapper()) {
        self.networkService = networkService
        self.requestBuilder = RequestBuilder(stringURL: baseURL)
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
