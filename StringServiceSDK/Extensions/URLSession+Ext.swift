//
//  URLSession+Ext.swift
//  StringServiceSDK
//
//  Created by Nuno Mendonça on 09/09/2024.
//

import Foundation

public protocol URLSessionProtocol {

    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
