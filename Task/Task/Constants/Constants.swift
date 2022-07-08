//
//  Constant.swift
//  Task
//
//  Created by Bala on 05/07/22.
//

import Foundation

struct APIEndPoints {
    static var baseUrl = "http://omdbapi.com"
    static var getfilmlist = "&s=Marvel&type=movie"
    static var apiKey = "b9bd48a6"
    static var elements = "/?apikey=\(apiKey)\(getfilmlist)"
}
