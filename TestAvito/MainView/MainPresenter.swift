//
//  MainPresenter.swift
//  TestAvito
//
//  Created by Михаил Милюша on 11.11.2021.
//

import Foundation
import UIKit

struct ViewData {
    let actionTitle: String
    let title: String
}

struct Order {
    var titleName: String
    var definition: String
    var price: String
    var imageUrl: String
    let imageCheckBox: String
}

class MainPresenter: MainViewOutputProtocol {
    unowned let view: MainViewInputProtocol
    var interactor: MainInteractorInputProtocol!
    
    required init(view: MainViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideMainData()
        interactor.getOrders()
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    
    func ordersDidRecieve(orderTypes: [Order]) {
        let section = OrderSection()
        orderTypes.forEach { order in
            section.rows.append(CollectionCell(order: order))
        }
        view.reloadData(for: section)
    }
    
    func receiveMainData(viewData: ViewData) {
        view.displayTitle(with: viewData.title)
        view.displayTitleBottomButton(with: viewData.actionTitle)
    }
    
    
}
