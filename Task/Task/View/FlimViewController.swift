//
//  ViewController.swift
//  Task
//
//  Created by Bala on 01/07/22.
//

import UIKit

class FlimViewController: UIViewController {

    @IBOutlet weak var collectionView : UICollectionView!
    
    lazy var viewModel : FilmViewModel = {
        return FilmViewModel()
    }()
    
    var filmSearchList = [Search]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVM()
        
    }
    
    func showAlert(_ message : String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func initVM(){
        self.viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        self.viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.initFetch()
    }
}
extension FlimViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.filmSearchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlimListCollectionViewCell", for: indexPath) as? FlimListCollectionViewCell else {
            fatalError("No cells in storyboard")
        }
        cell.configureCells(element: self.viewModel.filmSearchList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let divideValue = 2.0
        let cellWidth = collectionView.bounds.width - 10 / divideValue
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

