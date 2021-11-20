//
//  ViewController.swift
//  TestAvito
//
//  Created by Михаил Милюша on 07.11.2021.
//

import UIKit

protocol MainViewInputProtocol: AnyObject {
    func displayTitle(with title: String)
    func displayTitleBottomButton(with actionTitle: String)
    func reloadData(for section: OrderSection)
}

protocol MainViewOutputProtocol: AnyObject {
    init(view: MainViewInputProtocol)
    func showDetails()
}


extension MainViewController: MainViewInputProtocol {
    
    func reloadData(for section: OrderSection) {
        self.section = section
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    

    
    func displayTitleBottomButton(with actionTitle: String) {
        bottomButton.setTitle(actionTitle, for: .normal)
    }
    
    func displayTitle(with title: String) {
        titleLabel.text = title
    }
    
}

class MainViewController: UIViewController {
    
    
    
    var presenter: MainViewOutputProtocol!
    private let configurator: MainConfiguratorProtocol = MainConfigurator()
    private var section: SectionRowsRepresentable = OrderSection()
    
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        
        configurator.configure(with: self)
        configureViews()
        presenter.showDetails()
        
    }
}

// Конфигурируем состояние элементов MainView

extension MainViewController {
    
    func configureViews() {
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.numberOfLines = 3
        
        bottomButton.backgroundColor = UIColor(red: 76.0/255.0,
                                               green: 171.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1)
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.section.rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let orderCell = section.rows[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: orderCell.cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.orderCell = orderCell
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
}



