//
// CancelStopOrderRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Запрос отмены выставленной стоп-заявки. */

public struct CancelStopOrderRequest: Codable {

    public let accountId: String?
    public let stopOrderId: String?

    public init(accountId: String? = nil, stopOrderId: String? = nil) {
        self.accountId = accountId
        self.stopOrderId = stopOrderId
    }


}
