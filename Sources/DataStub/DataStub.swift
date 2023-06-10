//
//  DataStub.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
public struct DataStub : DataManager{
    public func load() -> [Ue] {
        return [
            Ue( nom: "Génie Logiciel", matieres: loadMartiereUE1(),coef: 6),
            Ue( nom: "Systèmes et réseaux", matieres: loadMartiereUE2(), coef: 6),
            Ue( nom: "Insertion Professionnelle", matieres: loadMartiereUE3(),coef: 6),
            Ue( nom: "Technologies Mobiles 1", matieres: loadMartiereUE4(),coef:9),
            Ue( nom: "Technologies Mobiles 2", matieres: loadMartiereUE5(),coef:9),
            Ue( nom: "Projet", matieres: loadMartiereUE6(),coef: 9),
            Ue( nom: "Stage", matieres: loadMartiereUE7(),coef: 15)
           
        ]
    }
    
    public func save(ues: [Ue]) {
       
    }
    
    
    public init(){}
    
    
    
    public func loadUeStage_Proj()->[Ue]{
        return [
            Ue( nom: "Projet", matieres: loadMartiereUE6(),coef: 9),
            Ue( nom: "Stage", matieres: loadMartiereUE7(),coef: 15)
           
        ]
    }
    
    func loadMartiereUE1()->[Matiere]{
        return [
            Matiere( name: "Processus de développement", moy: 12, coef: 4),
            Matiere( name: "Programmation Objets", moy: 12, coef: 9),
            Matiere( name: "Qualité de développpement", moy: 12, coef: 5),
            Matiere( name: "Remise à niveau objets", moy: 12, coef: 4)
        ]
    }
    
    func loadMartiereUE2()->[Matiere]{
        return [
            Matiere( name: "Internet des Objets", moy: 8, coef: 4),
            Matiere( name: "Réseaux", moy: 7, coef: 4),
            Matiere( name: "Services Mobiles", moy: 7, coef: 4),
            Matiere( name: "Système", moy: 7, coef: 4),
        ]
    }
    
    func loadMartiereUE3()->[Matiere]{
        return [
            Matiere( name: "Anglais", moy: 12, coef: 5),
            Matiere( name: "Economie", moy: 12, coef: 4),
            Matiere( name: "Gestion", moy: 12, coef: 3),
            Matiere( name: "Communication", moy: 12, coef: 4),
        ]
    }
    
    func loadMartiereUE4()->[Matiere]{
        return [
            Matiere( name: "Android", moy: 12, coef: 6),
            Matiere( name: "Architecture de projets C# .NET (1)", moy: 12, coef: 5),
            Matiere( name: "C++", moy: 12, coef: 4),
            Matiere( name: "Swift", moy: 12, coef: 5),
        ]
    }
    
    func loadMartiereUE5()->[Matiere]{
        return [
            Matiere( name: "Architecture de projets C# .NET (2)", moy: 12, coef: 4),
            Matiere( name: "Client/Serveur", moy: 12, coef: 4),
            Matiere( name: "iOS", moy: 12, coef: 5),
            Matiere( name: "Multiplateformes", moy: 12, coef: 3),
            Matiere( name: "QT Quick", moy: 12, coef: 5),
            Matiere( name: "Xamarin", moy: 12, coef: 5),
        ]
    }

    func loadMartiereUE6()->[Matiere]{
        return [
            Matiere( name: "Projet", moy: 12, coef: 9)
        ]
    }
    
    func loadMartiereUE7()->[Matiere]{
        return [
            Matiere( name: "Stage", moy: 12, coef: 15)
        ]
    }
}
