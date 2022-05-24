//
//  Broker.swift
//  tinkoff
//
//  Created by Jacob Chase on 3/04/21.
//

import Foundation


//MARK: - Enumeration types

enum BrokerAccountType: String, Codable {
    case Tinkoff, TinkoffIis 
}


enum Currency: String, Codable {
    case RUB, USD, EUR, GBP, HKD,
         CHF, JPY, CNY, TRY
}


enum OperationTypeWithCommission: String, Codable {
    case Buy, BuyCard, Sell, BrokerCommission,
         ExchangeCommission, ServiceCommission,
         MarginCommission, OtherCommission,
         PayIn, PayOut, Tax, TaxLucre, TaxDividend,
         TaxCoupon, TaxBack, Repayment, PartRepayment,
         Coupon, Dividend, SecurityIn, SecurityOut
}


enum InstrumentType: String, Codable {
    case Stock, Currency, Bond, Etf
}


enum OperationType: String, Codable {
    case Buy, Sell
}


enum OrderType: String, Codable {
    case Limit, Market
}


enum OrderStatus: String, Codable {
    case New, PartiallyFill, Fill, Cancelled,
         Replaced, PendingCancel, Rejected,
         PendingReplace, PendingNew
}


enum TradeStatus: String, Codable {
    case NormalTrading, NotAvailableForTrading
}


enum CandleResolution: String, Codable {
    case min1 = "1min"
    case min2 = "2min"
    case min3 = "3min"
    case min5 = "5min"
    case min10 = "10min"
    case min15 = "15min"
    case min30 = "30min"
    case hour, day, week, month
}


//MARK: - Payload structures

struct ErrorData: Codable {
    let message: String?
    let code: String?
}


struct NoData: Codable {
}


struct UserAccount: Codable {
    let brokerAccountType: BrokerAccountType
    let brokerAccountId: String
}


struct CurrencyPosition: Codable {
    let currency: Currency
    let balance: Double
    let blocked: Double?
}


struct MoneyAmount: Codable, Equatable {
    let currency: Currency
    let value: Double
}


struct OperationTrade: Codable {
    let tradeId, date: String
    let price: Double
    let quantity: Int
}


struct Offer: Codable {
    let price: Double
    let quantity: Int
}


struct Operation: Codable {
    let id, status: String
    let trades: [OperationTrade]?
    let commission: MoneyAmount?
    let currency: Currency
    let payment: Double
    let price: Double?
    let quantity, quantityExecuted: Int?
    let figi: String?
    let instrumentType: InstrumentType?
    let isMarginCall: Bool
    let date: String
    let operationType: OperationTypeWithCommission?
}


struct PortfolioPosition: Codable {
    let figi: String
    let ticker: String?
    let isin: String?
    let instrumentType: InstrumentType
    let balance: Double
    let blocked: Double?
    let expectedYield: MoneyAmount?
    let lots: Int
    let averagePositionPrice, averagePositionPriceNoNkd: MoneyAmount?
    let name: String
}


struct Order: Codable {
    let orderId: String
    let figi: String
    let operation: OperationType
    let status: OrderStatus
    let requestedLots, executedLots: Int
    let type: OrderType
    let price: Double
}


struct PlacedOrder: Codable {
    let orderId: String
    let operation: OperationType
    let status: OrderStatus
    let rejectReason, message: String?
    let requestedLots, executedLots: Int
    let commission: MoneyAmount?
}


struct SandboxRegisterRequest: Codable {
    let brokerAccountType: BrokerAccountType?
}


struct SandboxSetCurrencyBalanceRequest: Codable {
    let currency: Currency
    let balance: Double
}


struct SandboxSetPositionBalanceRequest: Codable {
    let figi: String?
    let balance: Double
}


struct LimitOrderRequest: Codable {
    let operation: OperationType
    let lots: Int
    let price: Double
    
    init(_ operation: OperationType, lots: Int, at price: Double) {
        self.operation = operation
        self.lots = lots
        self.price = price
    }
}


struct MarketOrderRequest: Codable {
    let lots: Int
    let operation: OperationType
    
    init(_ operation: OperationType, lots: Int) {
        self.operation = operation
        self.lots = lots
    }
}


struct MarketInstrument: Codable {
    let figi, ticker: String
    let isin: String?
    let minPriceIncrement: Double?
    let lot: Int
    let minQuantity: Int?
    let currency: Currency?
    let name: String
    let type: InstrumentType
}


struct Orderbook: Codable {
    let figi: String
    let depth: Int
    let bids: [Offer]
    let asks: [Offer]
    let tradeStatus: TradeStatus
    let minPriceIncrement: Double
    let faceValue: Double?
    let lastPrice, closePrice, limitUp, limitDown: Double?
}

struct Candle: Codable {
    let figi: String
    let interval: CandleResolution
    let o, c, h, l: Double
    let v: Int
    let time: String
}


struct UserAccounts: Codable {
    let accounts: [UserAccount]
}


struct Currencies: Codable {
    let currencies: [CurrencyPosition]
}


struct Operations: Codable {
    let operations: [Operation]
}


struct Portfolio: Codable {
    let positions: [PortfolioPosition]
}


struct MarketInstrumentList: Codable {
    let total: Int
    let instruments: [MarketInstrument]
    
    var first: MarketInstrument? { instruments.first }
}


struct Candles: Codable {
    let figi: String
    let interval: CandleResolution
    let candles: [Candle]
}


//MARK: - Request/Response structures

enum HTTPMethod: String { case get, post }

enum BrokerError: LocalizedError {
    case invalidUrl(String)
    case invalidJson(String)
    case serverError(String)

    public var errorDescription: String? {
        switch self {
        case .invalidUrl(let message): return ">> invalid URL: \(message)"
        case .invalidJson(let message): return ">> could not decode the following data as \(message)"
        case .serverError(let message): return ">> server error: \(message)"
        }
    }
}


struct Request {
    let method: HTTPMethod
    let endpoint: String
    var query: [URLQueryItem]?
    var body: Data?
    
    mutating func addParameter(_ parameter: String, _ value: String) {
        var rfc3986Allowed = CharacterSet.alphanumerics
        rfc3986Allowed.insert(charactersIn: "-._~")
        let encodedValue = value.addingPercentEncoding(withAllowedCharacters: rfc3986Allowed)
        
        let item = URLQueryItem(name: parameter, value: encodedValue)
        query?.append(item) ?? (query = [item])
    }
    
    mutating func setBody<T: Encodable>(to jsonObject: T) {
        body = try? JSONEncoder().encode(jsonObject)
    }
    
    init(_ method: HTTPMethod, _ endpoint: String, with accountId: String? = nil) {
        self.method = method
        self.endpoint = endpoint
        if let accountId = accountId { addParameter("brokerAccountId", accountId) }
    }
}


struct Response<Payload: Codable>: Codable {
    let trackingId: String
    let status: String
    var payload: Payload
    
    init?(_ data: Data) {
        do {
            self = try JSONDecoder().decode(Response.self, from: data)
        } catch {
            return nil
        }
    }
}


//MARK: - Main Class

class Broker {
    private let urlSession = URLSession(configuration: .default)
    private let token: String
    let isSandbox: Bool
    
    init(token: String, isSandbox: Bool) {
        self.token = token
        self.isSandbox = isSandbox
    }
    
    private func perform<T: Codable>(_ request: Request, completion: @escaping ResultHandler<T>) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api-invest.tinkoff.ru"
        components.path = "/openapi\(isSandbox ? "/sandbox" : "")\(request.endpoint)"
        components.percentEncodedQueryItems = request.query
            
        guard let url = components.url else {
            completion(.failure(BrokerError.invalidUrl(components.description)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.httpBody = request.body
        urlRequest.timeoutInterval = 10
        
        urlSession.httpRequest(with: urlRequest) { result in
            switch result {
            case let .failure(error):
                if let data = (error as? ResponseError)?.errorData, let message = Response<ErrorData>(data)?.payload.message {
                    completion(.failure(BrokerError.serverError(message)))
                } else {
                    completion(.failure(error))
                }
            case let .success(data):
                if let payload = Response<T>(data)?.payload {
                    completion(.success(payload))
                } else {
                    let jsonError = BrokerError.invalidJson("\(String(describing: T.self)): \(data.asText)")
                    completion(.failure(jsonError))
                }
            }
        }
    }
    
    
    // Sandbox methods
    func createSandboxAccount(_ type: BrokerAccountType, completion: @escaping ResultHandler<UserAccount>) {
        var request = Request(.post, "/sandbox/register")
        request.setBody(to: SandboxRegisterRequest(brokerAccountType: type))
        
        perform(request) { result in completion(result) }
    }
    
    func setSandboxBalance(_ currency: Currency, _ balance: Double, using accountId: String, completion: @escaping ResultHandler<NoData>) {
        var request = Request(.post, "/sandbox/currencies/balance", with: accountId)
        request.setBody(to: SandboxSetCurrencyBalanceRequest(currency: currency, balance: balance))
        
        perform(request) { result in completion(result) }
    }
    
    func setSandboxBalance(of figi: String, _ balance: Double, using accountId: String, completion: @escaping ResultHandler<NoData>) {
        var request = Request(.post, "/sandbox/positions/balance", with: accountId)
        request.setBody(to: SandboxSetPositionBalanceRequest(figi: figi, balance: balance))
        
        perform(request) { result in completion(result) }
    }
    
    func removeSandboxAccount(using accountId: String, completion: @escaping ResultHandler<NoData>) {
        perform(Request(.post, "/sandbox/remove", with: accountId)) { result in completion(result) }
    }
    
    func clearSandboxPositions(using accountId: String, completion: @escaping ResultHandler<NoData>) {
        perform(Request(.post, "/sandbox/clear", with: accountId)) { result in completion(result) }
    }
    
    // Orders methods
    func getOrders(using accountId: String, completion: @escaping ResultHandler<[Order]>) {
        perform(Request(.get, "/orders", with: accountId)) { result in completion(result) }
    }
    
    func createLimitOrder(_ order: LimitOrderRequest, for figi: String, using accountId: String, completion: @escaping ResultHandler<PlacedOrder>) {
        var request = Request(.post, "/orders/limit-order", with: accountId)
        request.addParameter("figi", figi)
        request.setBody(to: order)
        
        perform(request) { result in completion(result) }
    }
    
    func createMarketOrder(_ order: MarketOrderRequest, for figi: String, using accountId: String, completion: @escaping ResultHandler<PlacedOrder>) {
        var request = Request(.post, "/orders/market-order", with: accountId)
        request.addParameter("figi", figi)
        request.setBody(to: order)
        
        perform(request) { result in completion(result) }
    }
    
    func cancelOrderWithId(_ orderId: String, using accountId: String, completion: @escaping ResultHandler<NoData>) {
        var request = Request(.post, "/orders/cancel", with: accountId)
        request.addParameter("orderId", orderId)
        
        perform(request) { result in completion(result) }
    }
    
    // Portfolio methods
    func getPortfolio(using accountId: String, completion: @escaping ResultHandler<Portfolio>) {
        perform(Request(.get, "/portfolio", with: accountId)) { result in completion(result) }
    }
    
    func getPortfolioCurrencies(using accountId: String, completion: @escaping ResultHandler<Currencies>) {
        perform(Request(.get, "/portfolio/currencies", with: accountId)) { result in completion(result) }
    }
    
    // Market methods
    func getStocks(completion: @escaping ResultHandler<MarketInstrumentList>) {
        perform(Request(.get, "/market/stocks")) { result in completion(result) }
    }
    
    func getBonds(completion: @escaping ResultHandler<MarketInstrumentList>) {
        perform(Request(.get, "/market/bonds")) { result in completion(result) }
    }

    func getETFs(completion: @escaping ResultHandler<MarketInstrumentList>) {
        perform(Request(.get, "/market/etfs")) { result in completion(result) }
    }
    
    func getCurrencies(completion: @escaping ResultHandler<MarketInstrumentList>) {
        perform(Request(.get, "/market/currencies")) { result in completion(result) }
    }
    
    func getOrderBook(for figi: String, completion: @escaping ResultHandler<Orderbook>) {
        var request = Request(.get, "/market/orderbook")
        request.addParameter("figi", figi)
        request.addParameter("depth", "20")
        
        perform(request) { result in completion(result) }
    }
    
    func getCandles(for figi: String, from: String, to: String, withInterval interval: CandleResolution, completion: @escaping ResultHandler<Candles>) {
        var request = Request(.get, "/market/candles")
        request.addParameter("figi", figi)
        request.addParameter("from", from)
        request.addParameter("to", to)
        request.addParameter("interval", interval.rawValue)
        
        perform(request) { result in completion(result) }
    }
    
    func getInstrument(byFigi figi: String, completion: @escaping ResultHandler<MarketInstrument>) {
        var request = Request(.get, "/market/search/by-figi")
        request.addParameter("figi", figi)
        
        perform(request) { result in completion(result) }
    }
    
    func searchInstruments(byTicker ticker: String, completion: @escaping ResultHandler<MarketInstrumentList>) {
        var request = Request(.get, "/market/search/by-ticker")
        request.addParameter("ticker", ticker)
        
        perform(request) { result in completion(result) }
    }
    
    // Operations methods
    func getOperations(from: String, to: String, figi: String? = nil, using accountId: String, completion: @escaping ResultHandler<Operations>) {
        var request = Request(.get, "/operations", with: accountId)
        request.addParameter("from", from)
        request.addParameter("to", to)
        if let figi = figi { request.addParameter("figi", figi) }
        
        perform(request) { result in completion(result) }
    }

    // User methods
    func getUserAccounts(completion: @escaping ResultHandler<UserAccounts>) {
        perform(Request(.get, "/user/accounts")) { result in completion(result) }
    }
}
