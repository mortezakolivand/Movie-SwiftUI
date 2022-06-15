//
//  MovieViewModel.swift
//  Movie SwiftUI
//
//  Created by Morteza Kolivand on 15.06.2022.
//

import Foundation

class MovieViewModel:ObservableObject{
    
    @Published var movieList: [Movie]=[]
    
    func sortByDate()  {
        let sortedArray =   movieList.sorted {$0.releaseDate.compare($1.releaseDate, options: .numeric) == .orderedDescending}
        movieList = sortedArray
    }
    
    func sortByWatchOrder()  {
        movieList.sort { $0.watchOrder > $1.watchOrder }
    }
    
    func allMovies() {
        Webservice().getAllMovies() { (result) in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movieList = movies
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
