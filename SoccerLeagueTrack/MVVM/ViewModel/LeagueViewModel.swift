import Foundation

@MainActor
class LeagueViewModel: ObservableObject {
    @Published var teams: [TeamModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let leagueService: LeagueServicing
    
    init(leagueService: LeagueServicing = LeagueService()) {
        self.leagueService = leagueService
    }

    func fetchLookUpTable(leagueId: Int, season: String) async {
        isLoading = true
        errorMessage = nil

        let result = await leagueService.getLookUpTable(leagueId: leagueId, season: season)

        switch result {
        case .success(let teamModels):
            teams = teamModels
        case .error(let error):
            if let errorData = error.errorResponse {
                errorMessage = errorData.message
            } else {
                errorMessage = error.errorType.detail
            }
        }

        isLoading = false
    }
}
