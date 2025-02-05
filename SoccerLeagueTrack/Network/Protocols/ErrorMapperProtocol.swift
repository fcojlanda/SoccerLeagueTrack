protocol ErrorMapperProtocol {
    func map(statusCode: Int) -> ErrorNetworkType?
}
