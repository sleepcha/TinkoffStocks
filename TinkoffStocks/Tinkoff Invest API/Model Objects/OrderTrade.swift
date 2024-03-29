//
// OrderTrade.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Информация о сделке. */

public struct OrderTrade: Codable {

    public let dateTime: Date?
    public let price: Quotation?
    public let quantity: String?
    public let tradeId: String?

    public init(dateTime: Date? = nil, price: Quotation? = nil, quantity: String? = nil, tradeId: String? = nil) {
        self.dateTime = dateTime
        self.price = price
        self.quantity = quantity
        self.tradeId = tradeId
    }


}
