//
// CancelOrderRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

/** Запрос отмены торгового поручения. */

public struct CancelOrderRequest: Codable {
    public let accountId: String
    public let orderId: String
}
