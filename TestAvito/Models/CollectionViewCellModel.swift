//
//  CollectionViewCellModel.swift
//  TestAvito
//
//  Created by Михаил Милюша on 16.11.2021.
//

import Foundation

protocol CellIndentiIdentifier {
    var cellIdentifier: String { get }
    var cellHieght: Float { get }
}

protocol SectionRowsRepresentable {
    var rows: [CellIndentiIdentifier] { get set }
}

class CollectionCell: CellIndentiIdentifier {
    var cellIdentifier: String {
        "cell"
    }
    
    var cellHieght: Float {
        200
    }
    
    let titleName : String
    let definition: String
    let price: String
    let imageURL: String
//    let imageCheckBox: String
    
    init (order: Order) {
        titleName = order.titleName
        definition = order.definition
        price = order.price
        imageURL = order.imageUrl
 //       imageCheckBox = collectionViewData.imageCheckBox
    }
}

class OrderSection: SectionRowsRepresentable {
    var rows: [CellIndentiIdentifier] = []
}
