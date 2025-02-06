import Foundation

class MockProcessInfo: ProcessInfo {
    private var mockEnvironment: [String: String]

    init(mockEnvironment: [String: String]) {
        self.mockEnvironment = mockEnvironment
        super.init()
    }

    override var environment: [String: String] {
        return mockEnvironment
    }
}
