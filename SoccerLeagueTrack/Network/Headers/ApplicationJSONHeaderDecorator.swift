struct ApplicationJSONHeaderDecorator: HeaderDecorator {
    func decorateHeaders() -> [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
