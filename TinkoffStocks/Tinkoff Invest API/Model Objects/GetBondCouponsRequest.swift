//
// GetBondCouponsRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Запрос купонов по облигации. */

public struct GetBondCouponsRequest: Codable {

    public let figi: String?
    public let from: Date?
    public let to: Date?

    public init(figi: String? = nil, from: Date? = nil, to: Date? = nil) {
        self.figi = figi
        self.from = from
        self.to = to
    }


}
