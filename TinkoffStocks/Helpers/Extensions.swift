//
//  Extensions.swift
//  TinkoffStocks
//
//  Created by Jacob Chase on 1/10/21.
//

import Foundation
import UIKit


typealias ResultHandler<T> = (Result<T, Error>) -> Void
typealias Handler = () -> Void

enum NetworkError: LocalizedError {
    case emptyResponse(String)
    case emptyData(String)

    public var errorDescription: String? {
        switch self {
        case .emptyResponse(let message): return ">> empty response error: \(message)"
        case .emptyData(let message): return ">> empty data error: \(message)"
        }
    }
}

enum ResponseError: LocalizedError {
    case non200(HTTPURLResponse, Data?)
    
    var errorData: Data? {
        switch self {
        case .non200(_, let data): return data
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .non200(let response, _): return ">> non-200 response: \(response.description)"
        }
    }
}

extension URLSession {
    func httpRequest(with request: URLRequest, completion: @escaping ResultHandler<Data>) {
        self.dataTask(with: request) { data, response, error in 
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response else {
                completion(.failure(NetworkError.emptyResponse(request.description)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(ResponseError.non200(httpResponse, data)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.emptyData(request.description)))
            }
        }.resume()
    }
    
    func httpRequest(with url: String, completion: @escaping ResultHandler<Data>) {
        if let url = URL(string: url) {
            httpRequest(with: URLRequest(url: url), completion: completion)
        }
    }
}


func nestedCallChain(_ calls: [(@escaping ResultHandler<Void>) -> Void], completion: @escaping ResultHandler<Void>) {
    if let call = calls.first {
        call { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case .success:
                let restOfCalls = Array(calls.dropFirst())
                nestedCallChain(restOfCalls, completion: completion)
            }
        }
    } else {
        completion(.success(()))
    }
}


extension Data {
    var asText: String { String(data: self, encoding: .utf8) ?? "" }
}


fileprivate var iso8601: ISO8601DateFormatter {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "MSK")
    dateFormatter.formatOptions = [.withInternetDateTime, .withTimeZone]
    return dateFormatter
}


extension String {
    var asDate: Date? { iso8601.date(from: self) }
}


extension Date {
    var asIso8601String: String { iso8601.string(from: self) }
    
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    var day: Int { Calendar.current.component(.day, from: self) }
    var hour: Int { Calendar.current.component(.hour, from: self) }
    var min: Int { Calendar.current.component(.minute, from: self) }
}


extension Double {
    func formatted(as currency: Currency) -> String {
        let symbol: String
        switch currency {
        case .RUB: symbol = "₽"
        case .EUR: symbol = "€"
        case .USD: symbol = "$"
        default: symbol = ""
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = " "
        
        let value = formatter.string(from: NSNumber(value: self))!
        return "\(value) \(symbol)"
    }
    
    var twoDecimalPlaces: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self))!
    }
    
    var signCharacter: String { self == 0 ? "" : self > 0 ? "↑" : "↓" }
    
    var signColor: UIColor { self == 0 ? UIColor.label : self > 0 ? #colorLiteral(red: 0.1514248841, green: 0.7493237981, blue: 0.3914265609, alpha: 1) : #colorLiteral(red: 0.7982735148, green: 0.2066737924, blue: 0.1681413904, alpha: 1) }
}
