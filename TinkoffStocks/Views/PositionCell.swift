//
//  InstrumentCell.swift
//  TinkoffStocks
//
//  Created by Jacob Chase on 24/09/21.
//

import UIKit

class PositionCell: UITableViewCell {
    
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var gainLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    func createLetterLogo(_ firstLetter: Character, with width: CGFloat) -> UIImage? {
        let letter = String(firstLetter) as NSString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let fontSize: CGFloat = width * 0.5
        let letterAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.boldSystemFont(ofSize: fontSize),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]
        let rect = CGRect(x: 0, y: 0, width: width, height: width)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: width), false, 0)
        UIColor.systemGray.setFill()
        UIRectFill(rect)
        
        var textRect = rect
        textRect.origin.y = width / 2 - fontSize * 0.6
        letter.draw(in: textRect, withAttributes: letterAttributes)
        
        let logo = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return logo
    }
    
    func configure(with position: PricedPosition, _ gainPeriod: GainPeriod, _ color: UIColor) {
        cellBackgroundView.backgroundColor = color
        tickerLabel.text = position.ticker
        
        if let letter = position.ticker.first {
            logoImageView.image = createLetterLogo(letter, with: logoImageView.frame.width)
        }
        
        if let logoUrl = position.logoUrl {
            logoImageView.loadImage(withUrl: logoUrl)
        }
        
        nameLabel.text = position.name
        
        if let value = position.getMarketValue {
            valueLabel.text = "\(value.formatted(as: position.currency))"
        }
        
        gainLabel.attributedText = position.getGainDescription()
        
        if let price = position.marketPrice, let oldPrice = position.getOldPrice {
            priceChangeLabel.text = "\(oldPrice.formatted(as: position.currency)) → \(price.formatted(as: position.currency)) (\(position.balance.twoDecimalPlaces) шт.)"
        } else {
            priceChangeLabel.text = ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.layer.cornerRadius = 16
        logoImageView.layer.cornerRadius = 26
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension UIImageView {
    func loadImage(withUrl imageUrl: String) {
        URLSession.shared.httpRequest(with: imageUrl) { result in
            if let data = try? result.get() {
                DispatchQueue.main.async { self.image = UIImage(data: data) }
            }
        }
    }
}
