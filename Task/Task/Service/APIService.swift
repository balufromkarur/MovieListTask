//
//  APIService.swift
//  Task
//
//  Created by Bala on 07/07/22.
//

import Foundation

enum APIError : String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case noPermission = "Permission denied"
}

protocol APIServiceProtocol {
    func getFilmList(complete: @escaping ( _ success:Bool, _ result:[Search], _ error: APIError?)->())
}

class APIService : APIServiceProtocol {
    
    func getFilmList(complete: @escaping ( _ success:Bool, _ result:[Search], _ error: APIError?) -> ()) {
            let urlSession = URLSession.shared
            guard let url = URL(string: APIEndPoints.baseUrl + APIEndPoints.elements) else { return  }
            let urlRequest = URLRequest.init(url: url)
            
            urlSession.dataTask(with: urlRequest) { resultData, response, error in
                    guard let data = resultData else {
                        complete(false, [], error as? APIError)
                        return
                    }
                do {
                    let listModel = try JSONDecoder().decode(FilmListModel.self, from: data)
                    if let movieList = listModel.search {
                        complete(true, movieList, nil)
                    }
                }
                catch let error {
                    print(error)
                }
            }.resume()
        }
}
