//
// AssetCurrency.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Валюта. */

public struct AssetCurrency: Codable {

    public let baseCurrency: String?

    public init(baseCurrency: String? = nil) {
        self.baseCurrency = baseCurrency
    }


}
