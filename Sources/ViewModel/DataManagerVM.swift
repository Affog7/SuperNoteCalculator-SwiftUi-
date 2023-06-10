//
//  DataManagerVM.swift
//  Note
//
//  Created by etudiant on 09/06/2023.
//

import Foundation  

class ManagerVM: ObservableObject {
    @Published var ues: [UeVM] = []
    
    public init(withUes ues: [Ue]){
        self.ues = ues.map({UeVM(withUe: $0)})
    }
    
    public init(withUes ues: [UeVM]){
        self.ues = ues
    }
}
