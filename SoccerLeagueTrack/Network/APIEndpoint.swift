struct APIEndpoint {
    private static let basePath = "api/v1/json/3"
    
    static func lookUpTable(leagueId: Int, season: String) -> Endpoint {
        let path = "\(basePath)/lookuptable.php"
        let queryParams = ["l": "\(leagueId)", "s": season]
        return Endpoint(path: path, method: .GET, queryParams: queryParams)
    }
}
