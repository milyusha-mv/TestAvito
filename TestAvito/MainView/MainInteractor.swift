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
}

protocol MainInteractorOutputProtocol: AnyObject {
    func receiveMainData(viewData: ViewData)
    func ordersDidRecieve(orderTypes: [Order])
}

class MainInteractor: MainInteractorInputProtocol {
    
    unowned let presenter: MainInteractorOutputProtocol
    required init(presenter: MainInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func getOrders() {
        guard let answerData = RequestManager.shared.fetchLocalData() else {return}
        guard let lists = answerData.result?.list else { return }
        var orders: [Order] = []
        
        for index in 0...lists.count - 1 {
            var order = Order(titleName: "", definition: "", price: "", imageUrl: "", imageCheckBox: "")
            
            order.price = lists[index].price ?? ""
            order.titleName = lists[index].title ?? ""
            order.definition = lists[index].description ?? ""
            order.imageUrl = lists[index].icon?.size ?? ""
            
            orders.append(order)
        }
        presenter.ordersDidRecieve(orderTypes: orders)
    }
    
    func provideMainData() {
        
        var actionTitle: String = ""
        var title: String = ""
        
        guard let answerData = RequestManager.shared.fetchLocalData() else {return}
        
        actionTitle = answerData.result?.actionTitle ?? ""
        title = answerData.result?.title ?? ""
        
        let viewData = ViewData(actionTitle: actionTitle, title: title)
        
        presenter.receiveMainData(viewData: viewData)
    }
    
}

