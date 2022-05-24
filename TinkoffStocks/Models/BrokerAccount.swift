//
//  BrokerAccount.swift
//  TinkoffStocks
//
//  Created by Jacob Chase on 9/10/21.
//

import Foundation
import CloudKit

enum GainPeriod { case today, allTime }

enum AccountError: LocalizedError {
    case noRubleInCurrencyList(String)
    case noSelf
    public var errorDescription: String? {
        switch self {
        case .noRubleInCurrencyList(let message): return ">> no ruble position in account \(message)"
        case .noSelf: return ">> BrokerAccount.self is no longer available"
        }
    }
}

class BrokerAccount {
    private let brokerUser: BrokerUser
    private var broker: Broker { brokerUser.broker }
    private let id: String
    private let type: BrokerAccountType
    
    var name: String {
        switch type {
        case .Tinkoff: return "Брокерский счет"
        case .TinkoffIis: return "ИИС"
        }
    }
    var gainPeriod: GainPeriod = .today
    var marketValue: MoneyAmount?
    var todaysGain: MoneyAmount?
    var totalGain: MoneyAmount?
    private(set) var portfolio = [[PricedPosition]]()
    
    init(account: UserAccount, user: BrokerUser) {
        self.brokerUser = user
        self.id = account.brokerAccountId
        self.type = account.brokerAccountType
    }
        
    func updatePortfolio(completion: @escaping ResultHandler<Void>) {
        nestedCallChain([getPortfolio, setPrices]) { result in completion(result) }
    }
    
    private func getPortfolio(completion: @escaping ResultHandler<Void>) {
        broker.getPortfolioCurrencies(using: id) { [weak self] currenciesResult in
            guard let self = self else { return }
            self.broker.getPortfolio(using: self.id) { portfolioResult in
                completion(currenciesResult.flatMap { currencies in
                    return portfolioResult.map { portfolio in
                        var groupedPortfolio = self.convertToGroupedPortfolio(portfolio.positions)
                        if let rub = self.findRublePosition(currencies.currencies) {
                            if let index = groupedPortfolio.firstIndex(where: { $0.first?.instrumentType == .Currency }) {
                                groupedPortfolio[index].append(rub)
                            } else {
                                groupedPortfolio.append([rub])
                            }
                        }
                        self.portfolio = groupedPortfolio
                    }
                })
            }
        }
    }
    
    private func convertToGroupedPortfolio(_ positions: [PortfolioPosition]) -> [[PricedPosition]] {
        return positions.compactMap { PricedPosition($0, account: self) }
            .sorted { $0.ticker < $1.ticker }
            .reduce(into: [InstrumentType : [PricedPosition]]()) { $0[$1.instrumentType]?.append($1) ?? ($0[$1.instrumentType] = [$1]) }
            .sorted { $0.key.order < $1.key.order }
            .map { $0.value }
    }
    
    private func findRublePosition(_ positions: [CurrencyPosition]) -> PricedPosition? {
        if let rub = positions.first(where: { $0.currency == .RUB }) {
            return PricedPosition(rub, account: self)
        } else { return nil }
    }

    private func setPrices(completion: @escaping ResultHandler<Void>) {
        let dg = DispatchGroup()
        for position in portfolio.flatMap({ $0 }) {
            if position.figi == "" { continue }
            dg.enter()
            broker.getOrderBook(for: position.figi) { result in
                if case .success(let orderbook) = result {
                    position.marketPrice = orderbook.lastPrice
                    position.closePrice = orderbook.closePrice
                }
                dg.leave()
            }
        }
        dg.notify(queue: DispatchQueue.main) { completion(.success(())) }
    }
}


extension InstrumentType {
    var name: String {
        switch self {
        case .Stock: return "Акции"
        case .Currency: return "Валюта"
        case .Bond: return "Облигации"
        case .Etf: return "Фонды"
        }
    }
    
    var order: Int {
        switch self {
        case .Stock: return 1
        case .Currency: return 4
        case .Bond: return 2
        case .Etf: return 3
        }
    }
}

extension CurrencyPosition {
    var name: String {
        switch self.currency {
        case .RUB: return "Рубль"
        default: return currency.rawValue
        }
    }
}


extension BrokerAccount {
    func populateAccountWithPositions(amount: Int, completion: @escaping ResultHandler<Void>) {
        if !broker.isSandbox { return }
        broker.clearSandboxPositions(using: id) { _ in }
        broker.setSandboxBalance(.USD, 1000000, using: id) { _ in }
        broker.setSandboxBalance(.RUB, 7000000, using: id) { _ in }
        
        broker.getStocks { [weak self] result in
            completion(result.map { stockList in
                for _ in 1...amount {
                    let instrument = stockList.instruments.randomElement()!
                    guard let self = self else { break }
                    self.broker.setSandboxBalance(of: instrument.figi, 3, using: self.id) { result in
                        switch result {
                        case let .failure(error): print(error.localizedDescription)
                        case .success(_): break
                        }
                    }
//                    let order = LimitOrderRequest(.Buy, lots: 3, at: 123)
//                    createLimitOrder(order, for: instrument.figi) { result in
//                        switch result {
//                        case let .failure(error): print(error.localizedDescription)
//                        case let .success(data):
//                            print(data.message)
//                        }
//                    }
                }
            })
        }
    }
}
