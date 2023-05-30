//
//  UeCollection.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
struct UeCollection : Identifiable{
    var id : UUID
  
    var nom: String
    var ues: [Ue]
    
    init(nom: String, ues: [Ue]) {
        self.id = UUID()
        self.nom = nom
        self.ues = ues
    }
}
