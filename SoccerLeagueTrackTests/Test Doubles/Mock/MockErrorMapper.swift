@testable import SoccerLeagueTrack

class MockErrorMapper: ErrorMapping {
    var stubbedError: ErrorNetworkType?

    func map(statusCode: Int) -> ErrorNetworkType? {
        return stubbedError
    }
}
