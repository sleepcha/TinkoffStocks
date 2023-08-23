//
// OrderBookInstrument.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Запрос подписки на стаканы. */

public struct OrderBookInstrument: Codable {

    public let figi: String?
    public let depth: Int?
    public let instrumentId: String?

    public init(figi: String? = nil, depth: Int? = nil, instrumentId: String? = nil) {
        self.figi = figi
        self.depth = depth
        self.instrumentId = instrumentId
    }


}
