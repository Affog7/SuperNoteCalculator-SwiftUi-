//
//  UeVM.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
extension UeCollection  {
    struct Data :Identifiable {
        var id : UUID
      
        var nom: String
        var ues: [Ue]
    }
    
    var data : Data {
        Data(
            id : self.id,
             nom:self.nom ,
            ues: self.ues)
    }
    
    
   mutating func update(from data : Data){
        guard data.id == self.id else {return}
        self.nom = data.nom
       self.ues = data.ues
    }
}

class UeCollectionVM : ObservableObject{
    var original : UeCollection //= UeCollection(nom: "Mon UE", ues: DataStub().load())
    @Published var model : UeCollection.Data
    @Published var isEditing : Bool = false
    
    init(withUe ues : UeCollection) {
        self.original = ues
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
    
    
    func addUe(_ ue: Ue) {
        model.ues.append(ue)
    }
    
   
    
}


