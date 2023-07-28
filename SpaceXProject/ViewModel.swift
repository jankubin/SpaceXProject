//
//  ViewModel.swift
//  SpaceXProject
//
//  Created by Jan Kubín on 28.07.2023.
//

import Foundation

struct Response: Hashable, Codable {
    let name: String
    let details: String?
    let dateLocal: String
    let flightNumber: Int
    let links: Links
}

struct Links: Hashable, Codable {
    let patch: Patch?
}

struct Patch: Hashable, Codable {
    let small: String?
    let large: String?
}

class ViewModel: ObservableObject {
    @Published var spaceXLaunch: [Response] = []
    
    func fetch() {
        guard let url = URL(string: "https://api.spacexdata.com/v5/launches") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let spaceXLaunch = try decoder.decode([Response].self, from: data)
                DispatchQueue.main.async {
                    self.spaceXLaunch = spaceXLaunch
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func sort(by option: SortOption) {
        switch option {
        case .name:
            spaceXLaunch.sort { $0.name < $1.name }
        case .flightNumber:
            spaceXLaunch.sort { $0.flightNumber < $1.flightNumber }
        case .date:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            spaceXLaunch.sort { dateFormatter.date(from: $0.dateLocal)! < dateFormatter.date(from: $1.dateLocal)! }
        }
    }
}

