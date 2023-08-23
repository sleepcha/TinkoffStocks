//
// PositionsSubscriptionResult.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Объект результата подписки. */

public struct PositionsSubscriptionResult: Codable {

    public let accounts: [PositionsSubscriptionStatus]?

    public init(accounts: [PositionsSubscriptionStatus]? = nil) {
        self.accounts = accounts
    }


}
