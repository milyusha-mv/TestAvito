//
//  resultData.swift
//  TestAvito
//
//  Created by Михаил Милюша on 07.11.2021.
//

import Foundation

struct AnswerData: Codable {
    let status: String?
    let result: ResultData?
}

struct ResultData: Codable {
    let title: String?
    let actionTitle: String?
    let selectedActionTitle: String?
    let list: [ListData]?
}

struct ListData: Codable {
    let id: String?
    let title: String?
    let description: String?
    let icon: IconData?
    let price: String?
    let isSelected: Bool?
}

struct IconData: Codable {
    let size: String?
}



