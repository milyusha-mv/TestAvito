//
//  CollectionViewCell.swift
//  TestAvito
//
//  Created by Михаил Милюша on 16.11.2021.
//

import Foundation
import UIKit

protocol CellRepresentable {
    var orderCell: CellIndentiIdentifier? { get set }
}

class CollectionViewCell: UICollectionViewCell, CellRepresentable {
    
    @IBOutlet weak var cellUIImageView: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var checkBox: UIImageView!
    
    var orderCell: CellIndentiIdentifier? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let orderCell = orderCell as? OrderTypeCell else { return }
        cellTitle.text = orderCell.titleName
        definitionLabel.text = orderCell.definition
        definitionLabel.numberOfLines = 3
        
        priceLabel.text = orderCell.price
        priceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        guard let imageURL = URL(string: orderCell.imageURL) else { return }
        guard let imageData = RequestManager.shared.fetchImage(with: imageURL) else { return }
        cellUIImageView.image = UIImage(data: imageData)
        if orderCell.isCheched == false {
            checkBox.isHidden = true
        } else {
            checkBox.isHidden = false
        }
    }
}
