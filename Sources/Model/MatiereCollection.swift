//
//  UeCollection.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
struct MatiereCollection : Identifiable, Equatable{
    static func == (lhs: MatiereCollection, rhs: MatiereCollection) -> Bool {
        lhs.id == rhs.id
    }
    
    var id : UUID
  
    var nom: String
    var matieres: [Matiere]
    
    init(nom: String, matieres: [Matiere]) {
        self.id = UUID()
        self.nom = nom
        self.matieres = matieres
    }
}
