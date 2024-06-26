//
// OperationState.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

/** Статус запрашиваемых операций. */

public enum OperationState: String, Codable {
    case unspecified = "OPERATION_STATE_UNSPECIFIED"
    case executed = "OPERATION_STATE_EXECUTED"
    case canceled = "OPERATION_STATE_CANCELED"
    case progress = "OPERATION_STATE_PROGRESS"
}
