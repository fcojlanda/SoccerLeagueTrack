protocol LeagueServicing {
    var networkService: NetworkServicing { set get }
    var errorMapper: ErrorMapperProtocol { set get }
    
    func getLookUpTable(leagueId: Int, season: String) async -> ServiceResponse<[TeamModel]>
}
