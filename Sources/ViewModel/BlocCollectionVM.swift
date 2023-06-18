//
//  BlocCollectionVM.swift
//  Note
//
//  Created by etudiant on 10/06/2023.
//

import Foundation
class BlocCollectionVM : ObservableObject,Identifiable,Equatable {
    static func == (lhs: BlocCollectionVM, rhs: BlocCollectionVM) -> Bool {
        lhs.id == rhs.id
    }
    
     
    
       public var id: UUID { model.id }

   
    
    @Published var model : BlocCollection = BlocCollection( blocs: []){
        didSet{
            
            if !self.model.blocs.compare(to: self.someBlocVM.map({$0.model})){
             
                            self.someBlocVM = self.model.blocs.map({BlocVM(withBloc: $0)})
                        }
        }
    }
  
 
    
    @Published var someBlocVM: [BlocVM] = [] {
        didSet {
            let someModelBlocs = self.someBlocVM.map({$0.model})
                        if !self.model.blocs.compare(to: someModelBlocs) {
                            self.model.blocs = someBlocVM.map({$0.model})
             }
        }
    }

    
    init(withbloc blocs : BlocCollection) {
         self.model = blocs
    }
    
     
}




