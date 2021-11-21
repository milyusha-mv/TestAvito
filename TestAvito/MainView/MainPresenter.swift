//
//  MainPresenter.swift
//  TestAvito
//
//  Created by Михаил Милюша on 11.11.2021.
//

import Foundation


struct ViewData {
    let actionTitle: String
    let title: String
    let selectedActionTitle: String
}

struct OrderType {
    let titleName: String
    let definition: String
    let price: String
    let imageUrl: String
    var isCheked: Bool
    let isSelected: Bool
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
    
    func cellDidSelect(at indexPath: IndexPath)  {
        interactor.changeCheckedStatus(at: indexPath)
        interactor.changeBottomButtonTitle(at: indexPath)
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    
    func ordersDidRecieve(orderTypes: [OrderType]) {
        let section = OrderSection()
        orderTypes.forEach { orderType in
            section.rows.append(OrderTypeCell(orderType: orderType))
        }
        view.reloadData(for: section)
    }
    
    func mainDataDidRecive(viewData: ViewData) {
        view.displayTitle(with: viewData.title)
        view.displayTitleBottomButton(with: viewData.actionTitle)
    }
    
    func changeTitleBottomButton(title: String) {
        view.displayTitleBottomButton(with: title)
    }
}
