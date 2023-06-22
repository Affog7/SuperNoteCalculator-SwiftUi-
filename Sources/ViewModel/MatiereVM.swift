//
//  UeVM.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
 

class MatiereVM : ObservableObject, Identifiable, Equatable {
    
   
    private var notificationFuncs: [AnyHashable:(MatiereVM) -> ()] = [:]
        
    
    public func subscribe(with subscriber: AnyHashable, andWithFunction function:@escaping (MatiereVM) -> ()) {
        notificationFuncs[subscriber] = function
       }
    
    public func unsubscribe(with subscriber: AnyHashable) {
            notificationFuncs.removeValue(forKey: subscriber)
        }

    
    func notifyChanged(){
        for f in notificationFuncs.values {
                f(self)
            }
        }
    
    static func == (lhs: MatiereVM, rhs: MatiereVM) -> Bool {
        lhs.id == rhs.id
    }
    
    public var id: UUID { model.id }
     @Published var model : Matiere = Matiere(name: "", moy: 0, coef: 0)
    {
        
        didSet {
                    if self.name != self.model.name {
                        self.name = self.model.name
                    };
                    if self.moyenne != self.model.moyenne {
                                self.moyenne = self.model.moyenne
                            };
                    if self.coef != self.model.coef {
                                self.coef = self.model.coef
                            }
            self.notifyChanged()
                }
            }
 
    @Published
    var name: String = "" {
        didSet {
            if self.model.name != self.name {
                self.model.name = self.name
            }
         }
    }

    @Published
    var moyenne: Float=0 {
        didSet {
            if self.model.moyenne != self.moyenne {
                self.model.moyenne = self.moyenne
           
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
    
    public init(){}
    
    init(withMat mat : Matiere) {
        
        self.model = mat
    }
    
    
    
    @Published
        var isEditing: Bool = false
        
        private var copy: MatiereVM { MatiereVM(withMat: self.model) }
        
        var editedCopy: MatiereVM?
        
        func onEditing(){
            editedCopy = self.copy
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
    
}


