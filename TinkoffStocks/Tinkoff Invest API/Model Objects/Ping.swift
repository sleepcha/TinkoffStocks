//
// Ping.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Проверка активности стрима. */

public struct Ping: Codable {

    /** Время проверки. */
    public let time: Date?

    public init(time: Date? = nil) {
        self.time = time
    }


}
