//
// OrderTrades.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Информация об исполнении торгового поручения. */

public struct OrderTrades: Codable {

    public let orderId: String?
    public let createdAt: Date?
    public let direction: OrderDirection?
    public let figi: String?
    public let trades: [OrderTrade]?
    public let accountId: String?
    public let instrumentUid: String?

    public init(orderId: String? = nil, createdAt: Date? = nil, direction: OrderDirection? = nil, figi: String? = nil, trades: [OrderTrade]? = nil, accountId: String? = nil, instrumentUid: String? = nil) {
        self.orderId = orderId
        self.createdAt = createdAt
        self.direction = direction
        self.figi = figi
        self.trades = trades
        self.accountId = accountId
        self.instrumentUid = instrumentUid
    }


}
