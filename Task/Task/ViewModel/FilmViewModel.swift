//
//  ViewModel.swift
//  Task
//
//  Created by Bala on 01/07/22.
//

import UIKit

class FilmViewModel {

    let apiService: APIServiceProtocol
    
    var filmSearchList = [Search]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading : Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage : String? {
        didSet {
            self.showAlertClosure?()
        }
    }
        
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init(apiService : APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.getFilmList { [weak self] (success, result, error) in
            self?.isLoading = false
            if let err = error {
                self?.alertMessage = err.rawValue
            } else {
                self?.filmSearchList = result
            }
        }
    }
}
