//
//  UIKit+Extensions.swift
//  TinkoffStocks
//
//  Created by sleepcha on 5/9/24.
//

import UIKit

extension UILabel {
    enum Style {
        case title
        case subtitle
        case body

        var font: UIFont {
            switch self {
            case .title:
                .preferredFont(forTextStyle: .largeTitle).bold()
            case .subtitle:
                .preferredFont(forTextStyle: .subheadline)
            case .body:
                .preferredFont(forTextStyle: .body)
            }
        }

        var color: UIColor {
            switch self {
            case .title:
                .label
            case .subtitle:
                .secondaryLabel
            case .body:
                .label
            }
        }
    }

    convenience init(_ text: String, style: Style) {
        self.init()
        self.text = text
        font = style.font
        textColor = style.color
        addAccessibility()
    }

    private func addAccessibility() {
        numberOfLines = 0
        adjustsFontForContentSizeCategory = true
        setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}

extension UIView {
    func shake() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.prepare()

        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = [center.x - 10, center.y]
        animation.toValue = [center.x + 10, center.y]

        feedback.notificationOccurred(.error)
        layer.add(animation, forKey: "position")
    }
}

extension Collection where Element: UIResponder {
    /// Useful for finding a specific subview.
    func first(ofType typeName: String) -> Element? {
        first { String(describing: type(of: $0)) == typeName }
    }
}
