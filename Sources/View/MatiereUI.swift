//
//  Matiere.swift
//  Note
// 
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

struct MatiereUI: View {
    @ObservedObject var matiere : MatiereVM
     @State public var islocked : Bool = false
    var body: some View {
        VStack(alignment:.leading){
            Divider()
            HStack(spacing: 20){
                Text(matiere.model.name ).bold().font(.caption).padding()
                
            }
            
             
         
            HStack(spacing: 15){
                Button(action: {
                    islocked.toggle()
                }) {
                                          
                    Image(systemName: islocked ?  "lock.fill" : "lock.open.fill")
                }
                ExpandingCapsuleViewMatiere(mat: matiere, islock: islocked).frame(width:50,height: 20)

 Spacer()
                Text(matiere.model.moyenne.description)
                
                Spacer()
                Text(matiere.model.coef.description)
                
            }
            
        }.padding()
    }
}

struct Matiere_Previews: PreviewProvider {
    static var previews: some View {
        MatiereUI(matiere: MatiereVM(withMat: Matiere(name : "Projet",moy: 12, coef: 9)))
    }
}
