//
//  Movie.swift
//  Movie SwiftUI
//
//  Created by Morteza Kolivand on 14.06.2022.
//

import Foundation

class  Movie: Codable,  ObservableObject {
    let id: String
    let releaseDate: String
    let watchOrder: Int
    let title: String
    
}
 
