//
//  Bloc.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
public class Bloc :  Identifiable, Equatable {
    public static func == (lhs: Bloc, rhs: Bloc) -> Bool {
        lhs.id == rhs.id
    }
    
    var nom : String
    var isUnique : Bool 
    public var id : UUID
    var ues : [Ue]
    var total : Double {
        return Double(ues.reduce(0) { $0 + $1.totalMoyenne }) / Double(ues.count)
        }
    init(nom: String,  ues: [Ue], isUq : Bool) {
        self.id = UUID()
        self.nom = nom
        self.ues = ues
        self.isUnique = isUq
    }
    

}

extension Bloc : Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case nom
        case ues
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(nom, forKey: .nom)
        try container.encode(ues, forKey: .ues)
    }
    
}

struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String


        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
