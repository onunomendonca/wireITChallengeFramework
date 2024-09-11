//
//  StringService.swift
//  StringServiceSDK
//
//  Created by Nuno Mendonça on 09/09/2024.
//

import Foundation

/// `StringService` is the class responsible for sending a string to a remote server.
///
/// This class encapsulates the logic for communicating with the backend via an HTTP endpoint,
/// sending strings in JSON format. It uses a custom URL session through the `URLSessionProtocol`
/// protocol, allowing dependency injection for testing.
public class StringService {

    // MARK: - Properties

    /// The URL session used to send HTTP requests.
    private let session: URLSessionProtocol

    // MARK: - Initializer

    /// Initializes the `StringService` class with a custom session or the default `URLSession`.
    ///
    /// - Parameter session: Instance conforming to the `URLSessionProtocol`. The default value is `URLSession.shared`.
    ///
    /// Example of usage:
    /// let service = StringService() // Using the default URLSession
    /// or
    /// let service = StringService(session: URLMockSession) //Using a Mocked URLMockSession
    public init(session: URLSessionProtocol = URLSession.shared) {

        self.session = session
    }

    // MARK: - Methods

    /// Sends a string to the remote server.
    ///
    /// The string is sent in JSON format under the "myString" field. The function uses `async`/`await`
    /// and throws an error if the request fails or the server response is invalid.
    ///
    /// - Parameter string: The string to be sent to the server.
    ///
    /// - Throws: A `StringServiceError.invalidResponse` error if the server response is invalid.
    ///
    /// # Example of usage:
    /// ```
    /// Task {
    ///     do {
    ///         try await stringService.sendString("myString")
    ///         print("String successfully sent!")
    ///     } catch {
    ///         print("Error sending string: \(error)")
    ///     }
    /// }
    /// ```
    public func sendString(_ string: String) async throws {

        var urlRequest = try generateURLRequest()

        let body: [String: String] = ["myString": string]

        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (_, response) = try await self.session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {

            throw StringServiceError.invalidResponse
        }
    }
}

private extension StringService {

    /// Generates a `URLRequest` configured for the specific API endpoint.
    ///
    /// - Throws: Throws `StringServiceError.invalidURL` if the provided URL is invalid.
    /// - Returns: A configured `URLRequest` instance.
    func generateURLRequest() throws -> URLRequest {

        guard let url = URL(string: "https://us-central1-mobilesdklogging.cloudfunctions.net/saveString") else {

            throw StringServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
