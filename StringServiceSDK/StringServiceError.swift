//
//  StringServiceError.swift
//  StringServiceSDK
//
//  Created by Nuno Mendonça on 09/09/2024.
//

import Foundation

/// An enumeration representing possible errors that can occur in `StringService`.
///
/// These errors are thrown during the execution of the `sendString` method when something
/// goes wrong with the network request or the server's response.
public enum StringServiceError: Error {

    /// The URL used to communicate with the server is invalid.
    /// This error is thrown when the URL provided to `URLRequest` is malformed or cannot be created.
    case invalidURL

    /// The response from the server is invalid or not as expected.
    /// This error is thrown when the server returns a non-200 HTTP status code or an invalid response.
    case invalidResponse
}
