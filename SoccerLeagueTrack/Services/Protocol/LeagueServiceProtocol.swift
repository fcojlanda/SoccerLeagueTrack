protocol LeagueServiceProtocol {
    func getTable(league: Int, season: String) async -> Result<RawTeamModel, ServiceResponseError>
}
