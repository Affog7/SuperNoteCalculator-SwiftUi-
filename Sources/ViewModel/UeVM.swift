//
//  UeVM.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
 

class UeVM : ObservableObject, Identifiable, Equatable {
    static func == (lhs: UeVM, rhs: UeVM) -> Bool {
        lhs.id == rhs.id
    }
    
   /* public let id : UUID
     var nom: String
    var coef : Int
    var matieres: [Matiere]
*/
    @Published  var totalMoyenne: Double = 0 {
        didSet{
            var moy = updateTotalMoyenne()
            if moy != self.totalMoyenne {
                self.totalMoyenne = moy
            }
        }
    }
    
    public func updateTotalMoyenne()->Double {
        return Double(someMatieresVM.reduce(0) { $0 + $1.moyenne }) / Double(someMatieresVM.count)
    }
    
    @Published var model : Ue = DataStub().load()[0]{
        didSet{
            if self.model.nom != self.nom {
                self.nom = self.model.nom
            }
            if self.model.coef != self.coef {
                self.coef = self.model.coef
            }
            if !self.model.matieres.compare(to: self.someMatieresVM.map({$0.model})){
                            self.someMatieresVM = self.model.matieres.map({MatiereVM(withMat: $0)})
                        }
            var moy = updateTotalMoyenne()
            if moy != self.totalMoyenne {
                self.totalMoyenne = moy
            }

        }
    }
 
    init(withUe ue : Ue) {
        self.model = ue
         
     }
    public var id: UUID { model.id }

    @Published
    var nom: String = "" {
        didSet {
            if self.model.nom != self.nom {
                self.model.nom = self.nom
            }
        }
    }
    
    @Published
    var coef: Int = 0 {
        didSet {
            if self.model.coef != self.coef {
                self.model.coef = self.coef
             }
        }
    }
    
    
    @Published var someMatieresVM: [MatiereVM] = [] {
        didSet {
            let someModelMatiere = self.someMatieresVM.map({$0.model})
                        if !self.model.matieres.compare(to: someModelMatiere){
                            self.model.matieres = someModelMatiere.map({$0})
                        
            }
            
            print("vjgjjh")
          }
    }

    /*@Published var matieresVM: [MatiereVM] = [] {
            didSet {
                let someModelmatiere = self.matieresVM.map({$0.model})
                if !self.model.matieres.compare(to: someModelmatiere ){
                    self.model.matieres = matieresVM.map({$0.model})
                }
            }
        }*/

  
    
    
}


