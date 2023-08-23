//
// GetOperationsByCursorResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Список операций по счёту с пагинацией. */

public struct GetOperationsByCursorResponse: Codable {

    public let hasNext: Bool?
    public let nextCursor: String?
    public let items: [OperationItem]?

    public init(hasNext: Bool? = nil, nextCursor: String? = nil, items: [OperationItem]? = nil) {
        self.hasNext = hasNext
        self.nextCursor = nextCursor
        self.items = items
    }


}
