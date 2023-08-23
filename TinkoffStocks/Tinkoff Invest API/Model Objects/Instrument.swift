//
// Instrument.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Объект передачи основной информации об инструменте. */

public struct Instrument: Codable {

    public let figi: String?
    public let ticker: String?
    public let classCode: String?
    public let isin: String?
    public let lot: Int?
    public let currency: String?
    public let klong: Quotation?
    public let kshort: Quotation?
    public let dlong: Quotation?
    public let dshort: Quotation?
    public let dlongMin: Quotation?
    public let dshortMin: Quotation?
    public let shortEnabledFlag: Bool?
    public let name: String?
    public let exchange: String?
    public let countryOfRisk: String?
    public let countryOfRiskName: String?
    public let instrumentType: String?
    public let tradingStatus: SecurityTradingStatus?
    public let otcFlag: Bool?
    public let buyAvailableFlag: Bool?
    public let sellAvailableFlag: Bool?
    public let minPriceIncrement: Quotation?
    public let apiTradeAvailableFlag: Bool?
    public let uid: String?
    public let realExchange: RealExchange?
    public let positionUid: String?
    public let forIisFlag: Bool?
    public let forQualInvestorFlag: Bool?
    public let weekendFlag: Bool?
    public let blockedTcaFlag: Bool?
    public let instrumentKind: InstrumentType?
    public let first1minCandleDate: Date?
    public let first1dayCandleDate: Date?

    public init(figi: String? = nil, ticker: String? = nil, classCode: String? = nil, isin: String? = nil, lot: Int? = nil, currency: String? = nil, klong: Quotation? = nil, kshort: Quotation? = nil, dlong: Quotation? = nil, dshort: Quotation? = nil, dlongMin: Quotation? = nil, dshortMin: Quotation? = nil, shortEnabledFlag: Bool? = nil, name: String? = nil, exchange: String? = nil, countryOfRisk: String? = nil, countryOfRiskName: String? = nil, instrumentType: String? = nil, tradingStatus: SecurityTradingStatus? = nil, otcFlag: Bool? = nil, buyAvailableFlag: Bool? = nil, sellAvailableFlag: Bool? = nil, minPriceIncrement: Quotation? = nil, apiTradeAvailableFlag: Bool? = nil, uid: String? = nil, realExchange: RealExchange? = nil, positionUid: String? = nil, forIisFlag: Bool? = nil, forQualInvestorFlag: Bool? = nil, weekendFlag: Bool? = nil, blockedTcaFlag: Bool? = nil, instrumentKind: InstrumentType? = nil, first1minCandleDate: Date? = nil, first1dayCandleDate: Date? = nil) {
        self.figi = figi
        self.ticker = ticker
        self.classCode = classCode
        self.isin = isin
        self.lot = lot
        self.currency = currency
        self.klong = klong
        self.kshort = kshort
        self.dlong = dlong
        self.dshort = dshort
        self.dlongMin = dlongMin
        self.dshortMin = dshortMin
        self.shortEnabledFlag = shortEnabledFlag
        self.name = name
        self.exchange = exchange
        self.countryOfRisk = countryOfRisk
        self.countryOfRiskName = countryOfRiskName
        self.instrumentType = instrumentType
        self.tradingStatus = tradingStatus
        self.otcFlag = otcFlag
        self.buyAvailableFlag = buyAvailableFlag
        self.sellAvailableFlag = sellAvailableFlag
        self.minPriceIncrement = minPriceIncrement
        self.apiTradeAvailableFlag = apiTradeAvailableFlag
        self.uid = uid
        self.realExchange = realExchange
        self.positionUid = positionUid
        self.forIisFlag = forIisFlag
        self.forQualInvestorFlag = forQualInvestorFlag
        self.weekendFlag = weekendFlag
        self.blockedTcaFlag = blockedTcaFlag
        self.instrumentKind = instrumentKind
        self.first1minCandleDate = first1minCandleDate
        self.first1dayCandleDate = first1dayCandleDate
    }


}
