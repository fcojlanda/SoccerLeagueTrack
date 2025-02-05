import Foundation

struct RequestBuilder {
    private let baseURL: URL
    private var headerStrategies: [HeaderDecorator]
    
    init(stringURL: String, headerStrategies: [HeaderDecorator] = []) {
        guard let url = URL(string: stringURL) else {
            fatalError("Invalid URL: \(stringURL)")
        }
        
        self.baseURL = url
        self.headerStrategies = headerStrategies
        
        addHeaderStrategy(DefaultHeaderStrategy())
    }
    
    mutating func addHeaderStrategy(_ strategy: HeaderDecorator) {
        headerStrategies.append(strategy)
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
}
