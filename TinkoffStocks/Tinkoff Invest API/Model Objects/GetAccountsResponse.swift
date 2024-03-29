//
// GetAccountsResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Список счетов пользователя. */

public struct GetAccountsResponse: Codable {

    /** Массив счетов клиента. */
    public let accounts: [Account]?

    public init(accounts: [Account]? = nil) {
        self.accounts = accounts
    }


}
