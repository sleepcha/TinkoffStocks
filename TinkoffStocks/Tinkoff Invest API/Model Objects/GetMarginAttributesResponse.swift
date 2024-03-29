//
// GetMarginAttributesResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Маржинальные показатели по счёту. */

public struct GetMarginAttributesResponse: Codable {

    public let liquidPortfolio: MoneyValue?
    public let startingMargin: MoneyValue?
    public let minimalMargin: MoneyValue?
    public let fundsSufficiencyLevel: Quotation?
    public let amountOfMissingFunds: MoneyValue?
    public let correctedMargin: MoneyValue?

    public init(liquidPortfolio: MoneyValue? = nil, startingMargin: MoneyValue? = nil, minimalMargin: MoneyValue? = nil, fundsSufficiencyLevel: Quotation? = nil, amountOfMissingFunds: MoneyValue? = nil, correctedMargin: MoneyValue? = nil) {
        self.liquidPortfolio = liquidPortfolio
        self.startingMargin = startingMargin
        self.minimalMargin = minimalMargin
        self.fundsSufficiencyLevel = fundsSufficiencyLevel
        self.amountOfMissingFunds = amountOfMissingFunds
        self.correctedMargin = correctedMargin
    }


}
