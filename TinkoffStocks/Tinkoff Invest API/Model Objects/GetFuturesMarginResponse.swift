//
// GetFuturesMarginResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct GetFuturesMarginResponse: Codable {

    public let initialMarginOnBuy: MoneyValue?
    public let initialMarginOnSell: MoneyValue?
    public let minPriceIncrement: Quotation?
    public let minPriceIncrementAmount: Quotation?

    public init(initialMarginOnBuy: MoneyValue? = nil, initialMarginOnSell: MoneyValue? = nil, minPriceIncrement: Quotation? = nil, minPriceIncrementAmount: Quotation? = nil) {
        self.initialMarginOnBuy = initialMarginOnBuy
        self.initialMarginOnSell = initialMarginOnSell
        self.minPriceIncrement = minPriceIncrement
        self.minPriceIncrementAmount = minPriceIncrementAmount
    }


}
