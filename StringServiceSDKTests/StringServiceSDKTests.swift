//
//  StringServiceSDKTests.swift
//  StringServiceSDKTests
//
//  Created by Nuno Mendonça on 09/09/2024.
//

import XCTest
@testable import StringServiceSDK

final class StringServiceSDKTests: XCTestCase {

    var stringService: StringService!
    var mockSession: MockURLSession!

    override func setUp() {

        super.setUp()
        mockSession = MockURLSession()
        stringService = StringService(session: self.mockSession)
    }

    override func tearDown() {

        stringService = nil
        mockSession = nil
        super.tearDown()
    }

    func testSendStringSuccess() async {

        mockSession.nextResponse = HTTPURLResponse(url: URL(string: "https://www.google.com")!,
                                                   statusCode: 200,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        mockSession.nextData = Data()

        do {

            try await self.stringService.sendString("test")

        } catch {

            XCTFail("Error: Got an error when expected a Success: \(error)")
        }
    }

    func testSendStringInvalidURL() async {

        self.mockSession.nextResponse = HTTPURLResponse(url: URL(string: "https://jj")!,
                                                           statusCode: 400,
                                                           httpVersion: nil,
                                                           headerFields: nil)

        do {

            _ = try await self.stringService.sendString("shouldfailbtw")
            XCTFail("Error: should have been thrown with Invalid URL.")

        } catch {

            XCTAssertEqual(error as? StringServiceError, .invalidURL)
        }
    }
}
