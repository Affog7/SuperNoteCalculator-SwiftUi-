//
//  Bloc.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
public class Bloc : Identifiable, Equatable{
    public static func == (lhs: Bloc, rhs: Bloc) -> Bool {
        lhs.id == rhs.id
    }
    
    var nom : String
    
    var ues : [Ue]
    var total : Double {
        return Double(ues.reduce(0) { $0 + $1.totalMoyenne }) / Double(ues.count)
        }
    init(nom: String,  ues: [Ue]) {
        self.nom = nom
        self.ues = ues
    }
}
