//
//  Matiere.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation

struct Matiere : Identifiable, Equatable{
    
    static func == (lhs: Matiere, rhs: Matiere) -> Bool {
        lhs.id == rhs.id
    }
    let id: UUID
    var name: String
    var moyenne: Float
    var  coef : Int

    init( name: String, moy: Float, coef : Int) {
        self.id = UUID()
        self.name = name
        self.moyenne = moy
        self.coef = coef
    }
}
