//
//  DataManagerVM.swift
//  Note
//
//  Created by etudiant on 09/06/2023.
//

import Foundation  

class ManagerVM: ObservableObject, Hashable {
  
    static func == (lhs: ManagerVM, rhs: ManagerVM) -> Bool {
            lhs.blocs.compare(to: rhs.blocs)
        }
    
    @Published var blocs: [BlocVM]
    
    // abonnée
    func hash(into hasher: inout Hasher) {
            hasher.combine("manager")
        }
    
    func onNotifyChanged(source:BlocVM){
            self.objectWillChange.send()
        }
    
    public init(withBloc blocs: [Bloc]){
        self.blocs =  blocs.map({BlocVM(withBloc: $0)})
        self.blocs.forEach { blocvm in
            blocvm.subscribe(with: self, andWithFunction: onNotifyChanged(source:))
            
        }
    }
   
    var total : Double {
        return Double(blocs.reduce(0) { $0 + $1.totalMoyenne }) / Double(blocs.count)
        }
    
    public init(withBlocs blocs: [BlocVM]){
        self.blocs = blocs
        self.blocs.forEach { blocvm in
            blocvm.subscribe(with: self, andWithFunction: onNotifyChanged(source:))
               }
    }
}
