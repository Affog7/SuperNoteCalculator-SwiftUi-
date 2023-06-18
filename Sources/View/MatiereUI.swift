//
//  Matiere.swift
//  Note
// 
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

struct MatiereUI: View {
    @ObservedObject var matiere : MatiereVM
    @ObservedObject var ue : UeVM
    @ObservedObject var bloc : BlocVM
     @State   var islocked : Bool = true
    var body: some View {
        VStack(alignment:.leading){
            Divider()
            HStack(spacing: 20){
                Text(matiere.name ).bold().font(.caption).padding()
            }
            
         
            HStack(spacing: 15){
                Button(action: {
                    if self.matiere.isEditing {

                        self.matiere.onEdited(isCancelled: true)
                        print(self.matiere.moyenne)

                    } else {
                        self.matiere.onEditing()
                        
                    }
                }) {
                                          
                    Image(systemName: !matiere.isEditing ?  "lock.fill" : "lock.open.fill")
                }
                ExpandingCapsuleViewMatiere(matiere: matiere,  ue : ue, bloc : bloc ,islock: !matiere.isEditing).frame(width:50,height: 20)

                Spacer()
                Text(matiere.moyenne.description)
                
                Spacer()
                Text(matiere.coef.description)
                
            }
            
        }.padding()
    }
}

struct Matiere_Previews: PreviewProvider {
    static var previews: some View {
        MatiereUI(matiere: MatiereVM(withMat: Matiere(name : "Projet",moy: 12, coef: 9)), ue: UeVM(withUe: DataStub().loadUeStage_Proj()[0]),
                  bloc: BlocVM(withBloc: Bloc(nom: "", ues: DataStub().loadUeStage_Proj(), isUq: true)),
                  islocked: true)
    }
}
