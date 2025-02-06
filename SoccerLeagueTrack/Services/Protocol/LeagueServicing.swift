protocol LeagueServicing {
    var networkService: NetworkServicing { set get }
    var errorMapper: ErrorMapping { set get }
    
    func getLookUpTable(leagueId: Int, season: String) async -> ServiceResponse<[TeamModel]>
}
