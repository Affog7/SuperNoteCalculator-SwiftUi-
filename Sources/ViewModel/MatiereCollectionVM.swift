//
//  UeVM.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
extension MatiereCollection  {
    struct Data :Identifiable {
        let id : UUID
      
        var nom: String
        var matieres: [Matiere]
    }
    
    var data : Data {
        Data(
            id : self.id,
             nom:self.nom ,
            matieres: self.matieres)
    }
    
    
   mutating func update(from data : Data){
        guard data.id == self.id else {return}
        self.nom = data.nom
       self.matieres = data.matieres
    }
}

class MatiereCollectionVM : ObservableObject{
    var original : MatiereCollection //= UeCollection(nom: "Mon UE", ues: DataStub().load())
    @Published var model : MatiereCollection.Data
    @Published var isEditing : Bool = false
    
    init(withMat matieres : MatiereCollection) {
        self.original = matieres
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
    
    
    func addUe(_ mat: Matiere) {
        model.matieres.append(mat)
    }
    
   
    
}


