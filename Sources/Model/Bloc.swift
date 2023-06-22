//
//  Bloc.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
public class Bloc: Identifiable, Equatable, CustomStringConvertible {
    public static func == (lhs: Bloc, rhs: Bloc) -> Bool {
        lhs.id == rhs.id
    }
    
    var nom: String
    var isUnique: Bool
    public var id: UUID
    var ues: [Ue]
    var total: Double {
        return Double(ues.reduce(0) { $0 + $1.totalMoyenne }) / Double(ues.count)
    }
    
    init(nom: String, ues: [Ue], isUq: Bool) {
        self.id = UUID()
        self.nom = nom
        self.ues = ues
        self.isUnique = isUq
    }
    
    public var description: String {
        let uesString = ues.map { $0.description }.joined()
        return "\(nom),\(isUnique),\(id.uuidString);;;\(uesString)"
    }
}


 
