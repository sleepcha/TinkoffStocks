//
// HistoricCandle.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Информация о свече. */

public struct HistoricCandle: Codable {

    public let open: Quotation?
    public let high: Quotation?
    public let low: Quotation?
    public let close: Quotation?
    public let volume: String?
    public let time: Date?
    public let isComplete: Bool?

    public init(open: Quotation? = nil, high: Quotation? = nil, low: Quotation? = nil, close: Quotation? = nil, volume: String? = nil, time: Date? = nil, isComplete: Bool? = nil) {
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
        self.time = time
        self.isComplete = isComplete
    }

}
