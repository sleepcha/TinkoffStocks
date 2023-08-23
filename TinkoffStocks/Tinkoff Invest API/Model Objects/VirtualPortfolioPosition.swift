//
// VirtualPortfolioPosition.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct VirtualPortfolioPosition: Codable {

    public let positionUid: String?
    public let instrumentUid: String?
    public let figi: String?
    public let instrumentType: String?
    public let quantity: Quotation?
    public let averagePositionPrice: MoneyValue?
    public let expectedYield: Quotation?
    public let expectedYieldFifo: Quotation?
    public let expireDate: Date?
    public let currentPrice: MoneyValue?
    public let averagePositionPriceFifo: MoneyValue?

    public init(positionUid: String? = nil, instrumentUid: String? = nil, figi: String? = nil, instrumentType: String? = nil, quantity: Quotation? = nil, averagePositionPrice: MoneyValue? = nil, expectedYield: Quotation? = nil, expectedYieldFifo: Quotation? = nil, expireDate: Date? = nil, currentPrice: MoneyValue? = nil, averagePositionPriceFifo: MoneyValue? = nil) {
        self.positionUid = positionUid
        self.instrumentUid = instrumentUid
        self.figi = figi
        self.instrumentType = instrumentType
        self.quantity = quantity
        self.averagePositionPrice = averagePositionPrice
        self.expectedYield = expectedYield
        self.expectedYieldFifo = expectedYieldFifo
        self.expireDate = expireDate
        self.currentPrice = currentPrice
        self.averagePositionPriceFifo = averagePositionPriceFifo
    }


}
