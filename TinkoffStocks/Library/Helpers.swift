//
//  Helpers.swift
//  TinkoffStocks
//
//  Created by sleepcha on 8/23/23.
//

import Foundation

typealias ResultHandler<T> = (Result<T, Error>) -> Void

extension Result {
    var failure: Failure? {
        switch self {
        case let .failure(failure): failure
        default: nil
        }
    }

    var success: Success? {
        switch self {
        case let .success(success): success
        default: nil
        }
    }
}

func onMain<T>(closure: () throws -> T) rethrows -> T {
    try Thread.isMainThread ? closure() : DispatchQueue.main.sync { try closure() }
}