//
// Candle.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Пакет свечей в рамках стрима. */

public struct Candle: Codable {

    public let figi: String?
    public let interval: SubscriptionInterval?
    public let open: Quotation?
    public let high: Quotation?
    public let low: Quotation?
    public let close: Quotation?
    public let volume: String?
    public let time: Date?
    public let lastTradeTs: Date?
    public let instrumentUid: String?

    public init(figi: String? = nil, interval: SubscriptionInterval? = nil, open: Quotation? = nil, high: Quotation? = nil, low: Quotation? = nil, close: Quotation? = nil, volume: String? = nil, time: Date? = nil, lastTradeTs: Date? = nil, instrumentUid: String? = nil) {
        self.figi = figi
        self.interval = interval
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
        self.time = time
        self.lastTradeTs = lastTradeTs
        self.instrumentUid = instrumentUid
    }

}
