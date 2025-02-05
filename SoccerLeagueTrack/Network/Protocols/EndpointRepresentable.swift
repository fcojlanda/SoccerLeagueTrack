import Foundation

protocol EndpointRepresentable {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var queryParams: [String: String]? { get }
}
