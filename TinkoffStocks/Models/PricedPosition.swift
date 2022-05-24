//
//  PricedPosition.swift
//  tinkoff
//
//  Created by Jacob Chase on 20/04/21.
//

import Foundation
import UIKit



class PricedPosition {
    let usdFigi = "BBG0013HGFT4"
    static var usdRub: Double?
    
    private let brokerAccount: BrokerAccount
    private var period: GainPeriod { brokerAccount.gainPeriod }
    let figi: String
    let ticker: String
    let isin: String?
    let name: String
    let instrumentType: InstrumentType
    let balance: Double
    let lots: Int
    let averagePrice: Double
    var averageValue: Double { return averagePrice * balance }
    var currency: Currency
    
    var closePrice: Double?
    var marketPrice: Double? {
        didSet { if figi == usdFigi { PricedPosition.usdRub = marketPrice } }
    }
    
    var getMarketValue: Double? {
        marketPrice == nil ? nil : marketPrice! * balance
    }
    
    var getOldPrice: Double? {
        return period == .today ? closePrice : averagePrice
    }
    
    var getOldValue: Double? {
        if let price = getOldPrice {
            return balance * price
        } else { return nil }
    }
    
    func getGain(percentage: Bool = false) -> Double? {
        if let newPrice = marketPrice, let oldPrice = getOldPrice, oldPrice > 0 {
            let gain = percentage ? (newPrice / oldPrice - 1) * 100 : balance * (newPrice - oldPrice)
            return gain
        } else { return nil }
    }
    
    func getGainDescription() -> NSAttributedString {
        if let gain = getGain(), let percent = getGain(percentage: true) {
            let gainValue = abs(gain).formatted(as: currency)
            let gainPercent = abs(percent).twoDecimalPlaces
                        
            return NSAttributedString(string: "\(gain.signCharacter) \(gainValue) (\(gainPercent)%)",
                                      attributes: [.foregroundColor : gain.signColor])
        }
        return NSAttributedString(string: "")
    }
    
    var logoUrl: String? {
        if let isin = isin { return "https://static.tinkoff.ru/brands/traiding/\(isin)x160.png" }
        else { return nil }
    }
        
    init?(_ position: PortfolioPosition, account: BrokerAccount) {
        //guard let average = position.averagePositionPrice else { return nil }
        // 1337 is a sandbox stub, should simply return nil
        let average = position.averagePositionPrice ?? MoneyAmount(.USD, 1337)
        
        instrumentType = position.instrumentType
        if instrumentType == .Currency, let prefix = position.ticker?.prefix(3) { isin = String(prefix) }
        else { isin = position.isin }
        figi = position.figi
        ticker = position.ticker ?? ""
        name = position.name
        balance = position.balance
        lots = position.lots
        averagePrice = average.value
        currency = average.currency
        brokerAccount = account
    }
    
    init(_ position: CurrencyPosition, account: BrokerAccount) {
        instrumentType = .Currency
        ticker = position.currency.rawValue
        name = position.name
        isin = ticker
        balance = position.balance
        currency = position.currency
        averagePrice = 1
        marketPrice = 1
        lots = 1
        figi = ""
        brokerAccount = account
    }
}


extension MoneyAmount {
    init(_ currency: Currency, _ value: Double) {
        self.currency = currency
        self.value = value
    }
    
    var toRub: MoneyAmount? {
        switch currency {
        case .RUB:
            return self
        case .USD:
            if let usdRUB = PricedPosition.usdRub {
                return MoneyAmount(.RUB, self.value * usdRUB)
            } else { return nil }
        default:
            return nil
        }
    }
    
    var toUsd: MoneyAmount? {
        switch currency {
        case .RUB:
            if let usdRUB = PricedPosition.usdRub, usdRUB > 0 {
                return MoneyAmount(.USD, self.value / usdRUB)
            } else { return nil }
        case .USD:
            return self
        default:
            return nil
        }
    }
    
    var formatted: String {
        return value.formatted(as: currency)
    }
}
