//
// CancelStopOrderResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Результат отмены выставленной стоп-заявки. */

public struct CancelStopOrderResponse: Codable {

    public let time: Date?

    public init(time: Date? = nil) {
        self.time = time
    }


}
