//
//  ViewModel.swift
//  MoviesApp
//
//  Created by Mohammed Alsaleh on 22/11/1443 AH.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var data : Model?
    
    init() {
        self.getMovies()
    }
    
    func getMovies() {
        guard let url = URL(string:"https://api.themoviedb.org/3/trending/all/day?api_key=b0646aa6148385d7a33db4a0732addc4") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, err in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                let json = try! JSONDecoder().decode(Model.self, from: data!)
                DispatchQueue.main.async {
                    self.data = json
                }
            }
        }).resume()
    }
}
