//
// ProtobufAny.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ProtobufAny: Codable {

    public let typeUrl: String?
    public let value: Data?

    public init(typeUrl: String? = nil, value: Data? = nil) {
        self.typeUrl = typeUrl
        self.value = value
    }


}
