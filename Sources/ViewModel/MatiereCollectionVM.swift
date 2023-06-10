//
//  UeVM.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
 
class MatiereCollectionVM : ObservableObject,Identifiable,Equatable {
    static func == (lhs: MatiereCollectionVM, rhs: MatiereCollectionVM) -> Bool {
        lhs.id == rhs.id
    }
    
       public var id: UUID { model.id }

    /*
     var id : UUID
   
     var nom: String
     var matieres: [Matiere]
     */
    
    @Published var model : MatiereCollection  = MatiereCollection(nom: "", matieres: []){
        didSet{
            if self.model.nom != self.nom {
                self.nom = self.model.nom
            }
            if !self.model.matieres.compare(to: self.someMatieresVM.map({$0.model})){
                            self.someMatieresVM = self.model.matieres.map({MatiereVM(withMat: $0)})
                        }
        }
    }
  
    @Published var nom: String = "" {
        didSet {
            if self.model.nom != self.nom {
                self.model.nom = self.nom
            }
        }
    }
    
    @Published var someMatieresVM: [MatiereVM] = [] {
        didSet {
            let someModelMatiere = self.someMatieresVM.map({$0.model})
                        if !self.model.matieres.compare(to: someModelMatiere){
                            self.model.matieres = someMatieresVM.map({$0.model})
                        }
            print("vjgjjh")
        }
    }

    
    init(withMat matieres : MatiereCollection) {
         self.model = matieres
    }
    
    
     
    
   
    
}


