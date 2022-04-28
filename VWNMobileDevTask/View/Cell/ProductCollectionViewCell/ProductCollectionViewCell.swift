//
//  ProductCollectionViewCell.swift
//  MobileAppTask
//
//  Created by Omar Ahmed on 21/04/2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
