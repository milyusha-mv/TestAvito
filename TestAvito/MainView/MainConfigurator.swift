//
//  MainConfigurator.swift
//  TestAvito
//
//  Created by Михаил Милюша on 11.11.2021.
//

import Foundation

protocol MainConfiguratorProtocol: AnyObject {
    func configure(with view: MainViewController)
}

class MainConfigurator: MainConfiguratorProtocol {
    func configure(with view: MainViewController) {
        let presenter = MainPresenter(view: view)
        let interactor = MainInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
    
    
}
