//
// PostStopOrderRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Запрос выставления стоп-заявки. */

public struct PostStopOrderRequest: Codable {

    public let figi: String?
    public let quantity: String?
    public let price: Quotation?
    public let stopPrice: Quotation?
    public let direction: StopOrderDirection?
    public let accountId: String?
    public let expirationType: StopOrderExpirationType?
    public let stopOrderType: StopOrderType?
    public let expireDate: Date?
    public let instrumentId: String?

    public init(figi: String? = nil, quantity: String? = nil, price: Quotation? = nil, stopPrice: Quotation? = nil, direction: StopOrderDirection? = nil, accountId: String? = nil, expirationType: StopOrderExpirationType? = nil, stopOrderType: StopOrderType? = nil, expireDate: Date? = nil, instrumentId: String? = nil) {
        self.figi = figi
        self.quantity = quantity
        self.price = price
        self.stopPrice = stopPrice
        self.direction = direction
        self.accountId = accountId
        self.expirationType = expirationType
        self.stopOrderType = stopOrderType
        self.expireDate = expireDate
        self.instrumentId = instrumentId
    }


}
