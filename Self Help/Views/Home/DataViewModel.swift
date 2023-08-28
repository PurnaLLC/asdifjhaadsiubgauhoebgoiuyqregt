//
//  DataViewModel.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/27/23.
//
import Foundation

class DataViewModel: ObservableObject {
    @Published var dataOfTheDay: DataOfTheDay?

    init() {
        fetchData()
    }

    func fetchData() {
        fetchDataOfTheDay { [weak self] data in
            DispatchQueue.main.async {
                self?.dataOfTheDay = data
            }
        }
    }
}
