//
//  UeVM.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
 

class UeVM : ObservableObject, Identifiable, Equatable,Hashable {
    static func == (lhs: UeVM, rhs: UeVM) -> Bool {
        lhs.id == rhs.id
    }
    
    // Abonnée
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.nom)
        hasher.combine(self.totalMoyenne)
        }
    
    func onNotifyChanged(source:MatiereVM){
        if let index = self.model.matieres.firstIndex(where: {$0 == source.model}) {
            self.model.matieres[index] = source.model
        }
            self.objectWillChange.send()
        }
    
    
    //Emetteur // Broadcaster
    private var notificationFuncs: [AnyHashable:(UeVM) -> ()] = [:]

    public func subscribe(with subscriber: AnyHashable, andWithFunction function:@escaping (UeVM) -> ()) {
        notificationFuncs[subscriber] = function
       }
    
    public func unsubscribe(with subscriber: AnyHashable) {
            notificationFuncs.removeValue(forKey: subscriber)
        }

    
    
  ///  private var copy : MatiereVM
     func onNotifyChanged(){
        for f in notificationFuncs.values {
                f(self)
            }
        }
    
    //
   /* public let id : UUID
     var nom: String
    var coef : Int
    var matieres: [Matiere]
*/
    @Published  var totalMoyenne: Double = 0.0 {
        didSet{
            let moy = updateTotalMoyenne()
            if moy != self.totalMoyenne {
                self.totalMoyenne = moy
            }
            //self.notify()
        }
    }
    
    public func updateTotalMoyenne()->Double {
 

        let totalMoyenne = someMatieresVM.reduce(0.0) { $0 + Double($1.moyenne) * Double($1.coef) }
        let totalCoef = someMatieresVM.reduce(0.0) { $0 + Double($1.coef) }
       print("ue")
        print(self.someMatieresVM.count)
        return totalMoyenne / totalCoef

    }
    
    @Published var model : Ue = DataStub().load()[0]{
        willSet(newValue) {
                    if !self.someMatieresVM.map({$0.model}).compare(to: newValue.matieres){
                        self.someMatieresVM.forEach { $0.unsubscribe(with: self) }
                    }
                }
        didSet{
            if self.model.nom != self.nom {
                self.nom = self.model.nom
            }
            if self.model.coef != self.coef {
                self.coef = self.model.coef
            }
            if !self.model.matieres.compare(to: self.someMatieresVM.map({$0.model})){
                self.someMatieresVM = self.model.matieres.map({MatiereVM(withMat: $0)})
                self.someMatieresVM.forEach { mvm in
                    mvm.subscribe(with: self, andWithFunction: onNotifyChanged(source:))
                                }
           
            }
            
            
            let moy = updateTotalMoyenne()
            if moy != self.totalMoyenne {
                self.totalMoyenne = moy
            }

            
            self.onNotifyChanged()
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
          //  self.notify()
        }
    }
    
    @Published
    var coef: Int = 0 {
        didSet {
            if self.model.coef != self.coef {
                self.model.coef = self.coef
             }
            
           // self.notify()
        }
    }
    
    
    @Published var someMatieresVM: [MatiereVM] = [] {
        didSet {
            let someModelMatiere = self.someMatieresVM.map({$0.model})
                        if !self.model.matieres.compare(to: someModelMatiere){
                            self.model.matieres = someModelMatiere.map({$0})
                         
            }
            
            //self.notify()
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

    public init (){}
    @Published
    var isEditing: Bool = false
    
    private var copy: UeVM { UeVM(withUe: self.model) }
    
    var editedCopy: UeVM?
    
    func onEditing(){
        editedCopy = self.copy
        isAdding = false
        isEditing = true
    }
    
    func onEdited(isCancelled cancel: Bool = false) {
        if !cancel {
            if let editedCopy = editedCopy {
                self.model = editedCopy.model
            }
        }
        editedCopy = nil
        isEditing = false
    }
    
    var addedItem: MatiereVM?
    
    @Published
    var isAdding: Bool = false
    
    func onAdding() {
        addedItem = MatiereVM()
        isEditing = false
        isAdding = true
    }
    
    func onAdded(isCancelled cancel:Bool = false) {
           if !cancel {
               if let addedItem = addedItem {
                   self.someMatieresVM.append(addedItem)
                   addedItem.subscribe(with: self, andWithFunction: onNotifyChanged(source:))
               }
           }
           addedItem = nil
           isAdding = false
       }
    
    func onDeleted(_ matiere:MatiereVM, isCancelled cancel: Bool = false) {
        if !cancel {
            if self.someMatieresVM.contains(matiere) {
                self.someMatieresVM.filter { $0 == matiere }
                                   .forEach { $0.unsubscribe(with: self) }
                self.someMatieresVM.removeAll(where: {$0 == matiere})
            }
        }
    }
    
}


