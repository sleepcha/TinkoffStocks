//
//  AccountCollectionViewCell.swift
//  TinkoffStocks
//
//  Created by Jacob Chase on 22/09/21.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    static let cellHeight: Double = 162

    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var totalGainLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.layer.cornerRadius = 24
        // Initialization code
    }
    
    public func configure(with totalValue: String, _ totalGain: String) {
        totalValueLabel.text = totalValue
        totalGainLabel.text = totalGain
    }

}
