//
// SharesResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Данные по акциям. */

public struct SharesResponse: Codable {

    public let instruments: [Share]?

    public init(instruments: [Share]? = nil) {
        self.instruments = instruments
    }


}
