//
//  UE.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
struct Ue : Identifiable{
    let id : UUID
    var code: String
    var nom: String
    var coef : Int
    var matieres: [Matiere]

    var totalMoyenne: Double {
        return Double(matieres.reduce(0) { $0 + $1.moyenne }) / Double(matieres.count)
        }
    
    init(code: String, nom: String, matieres: [Matiere], coef : Int) {
        self.id = UUID()
        self.code = code
        self.nom = nom
        self.matieres = matieres
        self.coef = coef
    }
}

 

