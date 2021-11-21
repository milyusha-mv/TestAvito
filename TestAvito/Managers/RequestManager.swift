//
//  RequestManager.swift
//  TestAvito
//
//  Created by Михаил Милюша on 13.11.2021.
//

import Foundation
 

class RequestManager {
    private init () {}
    static let shared = RequestManager()
    
    func fetchLocalData() -> AnswerData? {
        var answerData: AnswerData?
        
        if let jsonData = readLocalFile(forName: "data") {
            do {
                answerData = try JSONDecoder().decode(AnswerData.self, from: jsonData)
                
            } catch let error {
                print(error)
            }
        }
        DataManager.shared.setAnswerData(answerData: answerData)
        return answerData
    }
    
    func fetchImage(with imageURL: URL?) -> Data? {
        
        guard let imageURL = imageURL else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        return imageData
    }
}

extension RequestManager {
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
