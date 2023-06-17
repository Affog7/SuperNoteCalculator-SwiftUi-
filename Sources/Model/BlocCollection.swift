//
//  BlocCollection.swift
//  Note
//
//  Created by etudiant on 10/06/2023.
//

import Foundation
struct BlocCollection : Identifiable, Equatable {
    
    
    var id : UUID
  
   
    var blocs: [Bloc]
    
    init(blocs: [Bloc]) {
        self.id = UUID()
        self.blocs = blocs
    }
}
