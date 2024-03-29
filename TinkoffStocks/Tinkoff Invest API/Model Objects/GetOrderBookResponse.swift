//
// GetOrderBookResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Информация о стакане. */

public struct GetOrderBookResponse: Codable {

    public let figi: String?
    public let depth: Int?
    public let bids: [Order]?
    public let asks: [Order]?
    public let lastPrice: Quotation?
    public let closePrice: Quotation?
    public let limitUp: Quotation?
    public let limitDown: Quotation?
    public let lastPriceTs: Date?
    public let closePriceTs: Date?
    public let orderbookTs: Date?
    public let instrumentUid: String?

    public init(figi: String? = nil, depth: Int? = nil, bids: [Order]? = nil, asks: [Order]? = nil, lastPrice: Quotation? = nil, closePrice: Quotation? = nil, limitUp: Quotation? = nil, limitDown: Quotation? = nil, lastPriceTs: Date? = nil, closePriceTs: Date? = nil, orderbookTs: Date? = nil, instrumentUid: String? = nil) {
        self.figi = figi
        self.depth = depth
        self.bids = bids
        self.asks = asks
        self.lastPrice = lastPrice
        self.closePrice = closePrice
        self.limitUp = limitUp
        self.limitDown = limitDown
        self.lastPriceTs = lastPriceTs
        self.closePriceTs = closePriceTs
        self.orderbookTs = orderbookTs
        self.instrumentUid = instrumentUid
    }


}
