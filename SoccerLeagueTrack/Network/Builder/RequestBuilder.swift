import Foundation

struct RequestBuilder: RequestBuilding {
    private let baseURL: URL
    private var headerStrategies: [HeaderDecorator]
    private var stringURL = APIEnvironment.current().baseURL
    
    init(stringURL: String? = nil, headerStrategies: [HeaderDecorator] = []) {
        
        if let stringURL = stringURL {
            self.stringURL = stringURL
        }
        
        guard let url = URL(string: self.stringURL) else {
            fatalError("Invalid URL: \(self.stringURL)")
        }
        
        self.baseURL = url
        self.headerStrategies = headerStrategies
        
        addHeaderStrategy(DefaultHeaderStrategy())
    }
    
    func buildRequest(for endpoint: Endpoint) throws -> URLRequest {
        var urlComponents = URLComponents(url: URL(string: endpoint.path, relativeTo: baseURL)!, resolvingAgainstBaseURL: true)
        
        if let queryParams = endpoint.queryParams {
            urlComponents?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let finalURL = urlComponents?.url else {
            throw ServiceResponseError(errorType: .invalidURL, errorResponse: nil)
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body

        var combinedHeaders: [String: String] = [:]
        headerStrategies.forEach { strategy in
            combinedHeaders.merge(strategy.decorateHeaders()) { _, new in new }
        }
        
        request.allHTTPHeaderFields = combinedHeaders
        return request
    }
    
    mutating func addHeaderStrategy(_ strategy: HeaderDecorator) {
        headerStrategies.append(strategy)
    }
}
