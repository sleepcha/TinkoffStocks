//
// LastPriceInstrument.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Запрос подписки на последнюю цену. */

public struct LastPriceInstrument: Codable {

    public let figi: String?
    public let instrumentId: String?

    public init(figi: String? = nil, instrumentId: String? = nil) {
        self.figi = figi
        self.instrumentId = instrumentId
    }


}
