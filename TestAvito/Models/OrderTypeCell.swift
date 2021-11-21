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

class OrderTypeCell: CellIndentiIdentifier {
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
    let isCheched: Bool
    
    init (orderType: OrderType) {
        titleName = orderType.titleName
        definition = orderType.definition
        price = orderType.price
        imageURL = orderType.imageUrl
        isCheched = orderType.isCheked
    }
}

class OrderSection: SectionRowsRepresentable {
    var rows: [CellIndentiIdentifier] = []
}
