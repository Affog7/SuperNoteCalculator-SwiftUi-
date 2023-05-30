//
//  UeVM.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
extension Ue {
    
    struct Data :Identifiable {
        
        let id : UUID
        var code: String
        
        var nom: String
        var coef: Int
        
        var matieres: [Matiere]
        
        var totalMoyenne: Double {
            return Double(matieres.reduce(0) { $0 + $1.moyenne }) / Double(matieres.count)
            }
    }
    
    var data : Data {
        Data(
            id : self.id,
            code :self.code ,
             nom :self.nom ,
             coef :self.coef ,
            matieres : self.matieres)
    }
    
    
   mutating func update(from data : Data){
        guard data.id == self.id else {return}
        self.code = data.code
        self.nom = data.nom
        self.coef = data.coef
        self.matieres = data.matieres
    }
}

class UeVM : ObservableObject {
    var original : Ue //= Ue(code: "66", nom: "hgg", matieres: [])
    @Published var model : Ue.Data
    @Published var isEditing : Bool = false
    
    init(withUe ue : Ue) {
        self.original = ue
        self.model = original.data
    }
    
    func onEditing(){
        model = original.data
        isEditing = true
    }
    
    
    func onEdited(isCancelled : Bool = false){
        if(!isCancelled){
            original.update(from: model)
        }
        isEditing = false
        model = original.data
    }
    
    
}


