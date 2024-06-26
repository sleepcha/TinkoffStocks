//
// BrandData.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

public struct BrandData: Codable {
    /// Логотип инструмента. Имя файла для получения логотипа.
    public let logoName: String

    /// Цвет бренда.
    public let logoBaseColor: String

    /// Цвет текста для цвета логотипа бренда.
    public let textColor: String
}
