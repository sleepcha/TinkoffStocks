//
// GetStopOrdersResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Список активных стоп-заявок. */

public struct GetStopOrdersResponse: Codable {

    public let stopOrders: [StopOrder]?

    public init(stopOrders: [StopOrder]? = nil) {
        self.stopOrders = stopOrders
    }


}
