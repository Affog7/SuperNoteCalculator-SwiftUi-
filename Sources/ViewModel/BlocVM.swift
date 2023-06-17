//
//  BlocVM.swift
//  Note
//
//  Created by etudiant on 10/06/2023.
//

import Foundation
class BlocVM : ObservableObject, Identifiable, Equatable, Hashable {
    static func == (lhs: BlocVM, rhs: BlocVM) -> Bool {
        lhs.id == rhs.id
    }
     
    // Abonnée
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.nom)
        hasher.combine(self.totalMoyenne)
        }
    
    func onNotifyChanged(source:UeVM){
        if let index = self.model.ues.firstIndex(where: {$0 == source.model}) {
            self.model.ues[index] = source.model
        }
            self.objectWillChange.send()
        }
   
    //Emetteur // Broadcaster
    private var notificationFuncs: [AnyHashable:(BlocVM) -> ()] = [:]

    public func subscribe(with subscriber: AnyHashable, andWithFunction function:@escaping (BlocVM) -> ()) {
        notificationFuncs[subscriber] = function
       }
    
    public func unsubscribe(with subscriber: AnyHashable) {
            notificationFuncs.removeValue(forKey: subscriber)
        }

    
  ///  private var copy : MatiereVM
    private func onNotifyChanged(){
        for f in notificationFuncs.values {
                f(self)
            }
        }
    
    
    @Published  var totalMoyenne: Double = 0.0 {
        didSet{
            let moy = updateTotalMoyenne()
            if moy != self.totalMoyenne {
                self.totalMoyenne = moy
            }
        }
    }
    
  public func updateTotalMoyenne()->Double {

      let totalMoyenne = self.someUesVM.reduce(0.0) { $0 + Double($1.totalMoyenne) * Double($1.coef) }
      let totalCoef = self.someUesVM.reduce(0.0) { $0 + Double($1.coef) }
      
      print("bloc")
      print(self.someUesVM.count)
        return totalMoyenne / totalCoef

    }
    
    @Published var model : Bloc = Bloc(nom: "Total", ues: DataStub().load()) {
        
        willSet(newValue) {
                    if !self.someUesVM.map({$0.model}).compare(to: newValue.ues){
                        self.someUesVM.forEach { uevm in
                            uevm.unsubscribe(with: self)
                        }
                    }
                }
        
        didSet{
            if self.model.nom != self.nom {
                self.nom = self.model.nom
            }
            
            if !self.model.ues.compare(to: self.someUesVM.map({$0.model})){
                            self.someUesVM = self.model.ues.map({UeVM(withUe: $0)})
                self.someUesVM.forEach { uevm in
                    uevm.subscribe(with: self, andWithFunction: onNotifyChanged(source:))
                 }
            }
            
            let moy = updateTotalMoyenne()
            if moy != self.totalMoyenne {
                self.totalMoyenne = moy
            }
            
            self.onNotifyChanged()
        }
    }
 
    init(withBloc blc : Bloc) {
        self.model = blc
         
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
    
     
    
    
    @Published var someUesVM: [UeVM] = [] {
        didSet {
            let someModelue = self.someUesVM.map({$0.model})
                        if !self.model.ues.compare(to: someModelue){
                            self.model.ues = someModelue.map({$0})
                        
            }
          }
    }
 
  
    
    
}


