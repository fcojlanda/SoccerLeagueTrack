import Foundation

struct Endpoint: EndpointRepresentable {
    let path: String
    let method: HTTPMethod
    let body: Data?
    let token: String?
    let queryParams: [String: String]?

    init(path: String,
         method: HTTPMethod,
         body: Data? = nil,
         token: String? = nil,
         queryParams: [String: String]? = nil) {
        
        self.path = path
        self.method = method
        self.body = body
        self.token = token
        self.queryParams = queryParams
    }
}
