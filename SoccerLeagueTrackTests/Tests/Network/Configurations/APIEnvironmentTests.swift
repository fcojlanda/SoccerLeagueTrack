@testable import SoccerLeagueTrack
import XCTest

final class APIEnvironmentTests: XCTestCase {
    private var originalEnvironment: [String: String]!

    override func setUp() {
        super.setUp()
        originalEnvironment = ProcessInfo.processInfo.environment
    }

    override func tearDown() {
        setEnvironmentVariables(originalEnvironment)
        super.tearDown()
    }

    func testAPIEnvironment_givenNoEnvironmentVariable_returnsProduction() {
        // Given
        setEnvironmentVariables([:])

        // When
        let currentEnvironment = APIEnvironment.current()

        // Then
        XCTAssertEqual(currentEnvironment, .development, "The default environment should be `.production` when no environment variable is set.")
    }

    func testAPIEnvironment_givenDevelopmentEnvironment_returnsDevBaseURL() {
        // Given
        let environment: APIEnvironment = .development

        // When
        let baseURL = environment.baseURL

        // Then
        XCTAssertEqual(baseURL, Constants.API.devBaseURL, "The baseURL should match the development base URL.")
    }

    func testAPIEnvironment_givenStagingEnvironment_returnsStagingBaseURL() {
        // Given
        let environment: APIEnvironment = .staging

        // When
        let baseURL = environment.baseURL

        // Then
        XCTAssertEqual(baseURL, Constants.API.stagingBaseURL, "The baseURL should match the staging base URL.")
    }

    func testAPIEnvironment_givenProductionEnvironment_returnsProdBaseURL() {
        // Given
        let environment: APIEnvironment = .production

        // When
        let baseURL = environment.baseURL

        // Then
        XCTAssertEqual(baseURL, Constants.API.prodBaseURL, "The baseURL should match the production base URL.")
    }
    
    private func setEnvironmentVariables(_ environment: [String: String]) {
        let mirroredProcessInfo = Mirror(reflecting: ProcessInfo.processInfo)
        if let environmentVariable = mirroredProcessInfo.children.first(where: { $0.label == "environment" })?.value as? [String: String] {
            environmentVariable.forEach { key, _ in unsetenv(key) }
            environment.forEach { key, value in setenv(key, value, 1) }
        }
    }
}
