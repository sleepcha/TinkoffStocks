//
// GetUserTariffResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Текущие лимиты пользователя. */

public struct GetUserTariffResponse: Codable {

    public let unaryLimits: [UnaryLimit]?
    public let streamLimits: [StreamLimit]?

    public init(unaryLimits: [UnaryLimit]? = nil, streamLimits: [StreamLimit]? = nil) {
        self.unaryLimits = unaryLimits
        self.streamLimits = streamLimits
    }


}
