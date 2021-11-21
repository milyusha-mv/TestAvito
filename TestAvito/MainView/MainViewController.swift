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
    func showAlert(with title: String, message: String)
}

protocol MainViewOutputProtocol: AnyObject {
    init(view: MainViewInputProtocol)
    func showDetails()
    func cellDidSelect(at indexPath: IndexPath)
    func buttomButtonDidSelect()
}


extension MainViewController: MainViewInputProtocol {
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
    
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
    private var checkedCells: [CollectionViewCell] = []
    
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        configureViews()
        presenter.showDetails()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    @IBAction func bottomButtonDidSelect() {
        presenter.buttomButtonDidSelect()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.cellDidSelect(at: indexPath)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: CGFloat(section.rows[indexPath.row].cellHieght))
    }
}


