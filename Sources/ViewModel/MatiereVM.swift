//
//  UeVM.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
extension Matiere {
    struct Data :Identifiable {
        let id: UUID
        var name: String
        var moyenne: Float
        var  coef : Int
    }
    
    var data : Data {
        Data(
            id : self.id,
            name:self.name,
            moyenne: self.moyenne,
             coef:self.coef )
    }
    
    
   mutating func update(from data : Data){
        guard data.id == self.id else {return}
         
        self.name = data.name
        self.coef = data.coef
        self.moyenne = data.moyenne
    }
}

class MatiereVM : ObservableObject{
    var original : Matiere //= Ue(code: "66", nom: "hgg", matieres: [])
    @Published var model : Matiere.Data
    @Published var isEditing : Bool = false
    
    init(withMat mat : Matiere) {
        self.original = mat
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


