//
//  MockURLSession.swift
//  StringServiceSDKTests
//
//  Created by Nuno Mendonça on 09/09/2024.
//

import Foundation
@testable import StringServiceSDK

class MockURLSession: URLSessionProtocol {

    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {

        if let error = self.nextError {
            throw error
        }

        let response = self.nextResponse ?? HTTPURLResponse(url: request.url!,
                                                            statusCode: 200,
                                                            httpVersion: nil,
                                                            headerFields: nil)!
        let data = self.nextData ?? Data()
        return (data, response)
    }
}
