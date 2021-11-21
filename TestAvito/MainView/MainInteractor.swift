//
//  MainInteractor.swift
//  TestAvito
//
//  Created by Михаил Милюша on 11.11.2021.
//

import Foundation

protocol MainInteractorInputProtocol: AnyObject {
    init(presenter: MainInteractorOutputProtocol)
    func provideMainData()
    func getOrders()
    func changeCheckedStatus(at indexPath: IndexPath)
    func changeBottomButtonTitle(at indexPath: IndexPath)
}

protocol MainInteractorOutputProtocol: AnyObject {
    func mainDataDidRecive(viewData: ViewData)
    func ordersDidRecieve(orderTypes: [OrderType])
    func changeTitleBottomButton(title: String)
}

class MainInteractor: MainInteractorInputProtocol {
    unowned let presenter: MainInteractorOutputProtocol
    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func getOrders() {
        var orders: [OrderType] = []
        var answerData = DataManager.shared.getAnswerDara()
        
        if answerData == nil { answerData = RequestManager.shared.fetchLocalData() }
        
        guard let answerData = RequestManager.shared.fetchLocalData() else {return}
        guard let lists = answerData.result?.list else { return }
        for index in 0...lists.count - 1 {
            
            let price = lists[index].price ?? ""
            let titleName = lists[index].title ?? ""
            let definition = lists[index].description ?? ""
            let imageUrl = lists[index].icon?.size ?? ""
            let isSelected = lists[index].isSelected ?? false
            let order = OrderType(titleName: titleName,
                                  definition: definition,
                                  price: price,
                                  imageUrl: imageUrl,
                                  isCheked: false,
                                  isSelected: isSelected)
            if order.isSelected == true {
                orders.append(order)
                
            }
        }
        DataManager.shared.setOrders(orders: orders)
        presenter.ordersDidRecieve(orderTypes: orders)
    }
    
    func provideMainData() {
        let viewData: ViewData
        var answerData = DataManager.shared.getAnswerDara()
        
        if answerData == nil { answerData = RequestManager.shared.fetchLocalData() }
        guard let answerData = RequestManager.shared.fetchLocalData() else {return}
        
        let actionTitle = answerData.result?.actionTitle ?? ""
        let title = answerData.result?.title ?? ""
        let selectedActionTitle = answerData.result?.selectedActionTitle ?? ""
        
        viewData = ViewData(actionTitle: actionTitle, title: title, selectedActionTitle: selectedActionTitle)
        presenter.mainDataDidRecive(viewData: viewData)
    }
    
    func changeCheckedStatus(at indexPath: IndexPath) {
        var orders = DataManager.shared.getOrders()
        
        for index in 0...orders.count - 1 {
            if index != indexPath.row {
                orders[index].isCheked = false
            } else {
                orders[index].isCheked.toggle()
            }
            DataManager.shared.setOrders(orders: orders)
            presenter.ordersDidRecieve(orderTypes: orders)
        }
    }
    
    func changeBottomButtonTitle(at indexPath: IndexPath) {
        let orders = DataManager.shared.getOrders()
        var answerData = DataManager.shared.getAnswerDara()
        
        if answerData == nil { answerData = RequestManager.shared.fetchLocalData() }
        guard let answerData = RequestManager.shared.fetchLocalData() else {return}
        
        let actionTitle = answerData.result?.actionTitle ?? ""
        let selectedActionTitle = answerData.result?.selectedActionTitle ?? ""
        
        for index in 0...orders.count - 1 {
            if orders[index].isCheked == true {
                presenter.changeTitleBottomButton(title: selectedActionTitle)
                break
            } else {
                presenter.changeTitleBottomButton(title: actionTitle)
                
            }
        }
        presenter.ordersDidRecieve(orderTypes: orders)
    }
}

