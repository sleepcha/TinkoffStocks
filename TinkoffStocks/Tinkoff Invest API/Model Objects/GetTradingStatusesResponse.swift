//
// GetTradingStatusesResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Информация о торговом статусе. */

public struct GetTradingStatusesResponse: Codable {

    public let tradingStatuses: [GetTradingStatusResponse]?

    public init(tradingStatuses: [GetTradingStatusResponse]? = nil) {
        self.tradingStatuses = tradingStatuses
    }


}
