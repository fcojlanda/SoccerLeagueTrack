import Foundation

struct TeamModel {
    var idStanding: Int?
    var intRank: Int?
    var idTeam: Int?
    var strTeam: String?
    var strBadge: URL?
    var idLeague: Int?
    var strLeague: String?
    var strSeason: String?
    var strForm: String?
    var strDescription: String?
    var intPlayed: Int?
    var intWin: Int?
    var intLoss: Int?
    var intDraw: Int?
    var intGoalsFor: Int?
    var intGoalsAgainst: Int?
    var intGoalDifference: Int?
    var intPoints: Int?
    var dateUpdated: Date?
    
    init(from rawModel: RawTeamModel) {
        self.idStanding = rawModel.idStanding?.convertToInt()
        self.intRank = rawModel.intRank?.convertToInt()
        self.idTeam = rawModel.idTeam?.convertToInt()
        self.strTeam = rawModel.strTeam
        self.strBadge = rawModel.strBadge?.convertToURL()
        self.idLeague = rawModel.idLeague?.convertToInt()
        self.strLeague = rawModel.strLeague
        self.strSeason = rawModel.strSeason
        self.strForm = rawModel.strForm
        self.strDescription = rawModel.strDescription
        self.intPlayed = rawModel.intPlayed?.convertToInt()
        self.intWin = rawModel.intWin?.convertToInt()
        self.intLoss = rawModel.intLoss?.convertToInt()
        self.intDraw = rawModel.intDraw?.convertToInt()
        self.intGoalsAgainst = rawModel.intGoalsAgainst?.convertToInt()
        self.intGoalDifference = rawModel.intGoalDifference?.convertToInt()
        self.intPoints = rawModel.intPoints?.convertToInt()
        self.dateUpdated = rawModel.dateUpdated?.convertToDate()
    }
}
