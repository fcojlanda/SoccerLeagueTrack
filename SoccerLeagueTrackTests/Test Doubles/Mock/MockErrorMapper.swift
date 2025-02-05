@testable import SoccerLeagueTrack

class MockErrorMapper: ErrorMapperProtocol {
    var stubbedError: ErrorNetworkType?

    func map(statusCode: Int) -> ErrorNetworkType? {
        return stubbedError
    }
}
