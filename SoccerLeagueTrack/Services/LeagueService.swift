import Foundation

class LeagueService {
    private let networkService: NetworkService
    private let requestBuilder: RequestBuilder

    init(networkService: NetworkService, baseURL: String, errorMapper: ErrorRequestMapper = ErrorRequestMapper()) {
        self.networkService = networkService
        self.requestBuilder = RequestBuilder(stringURL: baseURL)
        self.errorMapper = errorMapper
    }

    func getLookUpTable(leagueId: Int, season: String) async -> ServiceResponse<[TeamModel]> {
        let endpoint = APIEndpoint.lookUpTable(leagueId: leagueId, season: season)
        let result = await networkService.performRequest(for: endpoint, decodingType: TableResponse.self)

        switch result {
        case .success(let tableResponse):
            do {
                let teamModels = tableResponse.table.map { TeamModel(from: $0) }
                return .success(teamModels)
            } catch {
                return .error(error)
            }

        case .failure(let error):
            return .error(error)
        }
    }
}
