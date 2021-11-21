//
//  DataManager.swift
//  TestAvito
//
//  Created by Михаил Милюша on 21.11.2021.
//

import Foundation

class DataManager {
    private init () {}
    static let shared = DataManager()
    
    private var answerData: AnswerData?
    private var orders: [OrderType] = []
    
    func setAnswerData(answerData: AnswerData?) {
        guard let answerdData = answerData else { return }
        self.answerData = answerdData
    }
    
    func getAnswerDara() -> AnswerData? {
        answerData
    }
    
    func setOrders(orders: [OrderType]) {
        self.orders = orders
    }
    
    func getOrders() -> [OrderType] {
        orders
    }
}
