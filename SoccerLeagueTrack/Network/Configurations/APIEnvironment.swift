import Foundation

enum APIEnvironment: String {
    case development = "DEV"
    case staging = "STAGING"
    case production = "PROD"

    var baseURL: String {
        switch self {
        case .development:
            return Constants.API.devBaseURL
        case .staging:
            return Constants.API.stagingBaseURL
        case .production:
            return Constants.API.prodBaseURL
        }
    }

    static func current() -> APIEnvironment {
        let environmentString = ProcessInfo.processInfo.environment["API_ENVIRONMENT"] ?? "PROD"
        return APIEnvironment(rawValue: environmentString) ?? .production
    }
}
