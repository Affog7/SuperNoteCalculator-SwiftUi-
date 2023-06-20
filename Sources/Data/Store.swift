//
//  Store.swift
//  Note
//
//  Created by Sagbo Augustin AFFOGNON on 20/06/2023.
//

import Foundation
class Store : ObservableObject {
    @Published var blocs: [Bloc] = []

    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("scrums.data")

    }
    
    
    
    func load() async throws {
        let task = Task<[Bloc], Error> {
            let fileURL = try Self.fileURL()
                       guard let data = try? Data(contentsOf: fileURL) else {
                           return []
                       }
            let blocs = try JSONDecoder().decode([Bloc].self, from: data)
            return blocs


        }
        
        let scrums = try await task.value

        
    }
    
    
}
