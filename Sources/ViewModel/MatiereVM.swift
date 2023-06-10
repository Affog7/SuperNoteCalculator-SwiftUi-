//
//  UeVM.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import Foundation
 

class MatiereVM : ObservableObject, Identifiable, Equatable {
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
                    
                }
            }
    /**
     
     var name: String
     var moyenne: Float
     var  coef : Int
     */
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
    
    
    init(withMat mat : Matiere) {
        
        self.model = mat
    }
    
    
    
    
}


