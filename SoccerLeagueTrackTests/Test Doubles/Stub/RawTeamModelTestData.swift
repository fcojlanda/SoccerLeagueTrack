import Foundation

enum RawTeamModelTestData {
    static var validJSONData: Data {
        return """
        {
            "idStanding": "1",
            "intRank": "2",
            "idTeam": "101",
            "strTeam": "Test Team",
            "strBadge": "https://example.com/badge.png",
            "idLeague": "500",
            "strLeague": "Test League",
            "strSeason": "2023",
            "strForm": "WWLL",
            "strDescription": "A test description",
            "intPlayed": "10",
            "intWin": "6",
            "intLoss": "2",
            "intDraw": "2",
            "intGoalsFor": "20",
            "intGoalsAgainst": "10",
            "intGoalDifference": "10",
            "intPoints": "18",
            "dateUpdated": "2021-06-17 23:00:11"
        }
        """.data(using: .utf8)!
    }

    static var partialJSONData: Data {
        return """
        {
            "idStanding": "1",
            "strTeam": "Partial Team"
        }
        """.data(using: .utf8)!
    }

    static var invalidJSONData: Data {
        return """
        {
            "idStanding": 1,
            "intRank": "2"
        }
        """.data(using: .utf8)!
    }

    static var emptyJSONData: Data {
        return "{}".data(using: .utf8)!
    }
    
    static var jsonWithIntsData = """
        {
            "idStanding": 1,
            "intRank": 2,
            "strTeam": "Team with Int Fields",
            "intGoalsFor": 25
        }
        """.data(using: .utf8)!
    
    static var jsonWithBooleanData = """
        {
            "idStanding": true,
            "strTeam": "Team with Boolean Field"
        }
        """.data(using: .utf8)!
    
    static var jsonWithIncorrectDate = """
        {
            "dateUpdated": 1234567890
        }
        """.data(using: .utf8)!
    
    static var jsonWithCorrecDate = """
        {
            "dateUpdated": "2023-01-30"
        }
        """.data(using: .utf8)!
    
    static var errorResponseData = """
    {
        "message": "An error occurred",
        "status": 400
    }
    """.data(using: .utf8)
}
