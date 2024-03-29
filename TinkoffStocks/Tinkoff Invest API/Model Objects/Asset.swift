//
// Asset.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Информация об активе. */

public struct Asset: Codable {

    public let uid: String?
    public let type: AssetType?
    public let name: String?
    public let instruments: [AssetInstrument]?

    public init(uid: String? = nil, type: AssetType? = nil, name: String? = nil, instruments: [AssetInstrument]? = nil) {
        self.uid = uid
        self.type = type
        self.name = name
        self.instruments = instruments
    }


}
