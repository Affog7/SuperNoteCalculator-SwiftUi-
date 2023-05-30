//
//  UE.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

struct UE: View {
   @ObservedObject var ue : UeVM
    var body: some View {
        
        VStack(alignment:.leading){
            Divider()
            HStack(spacing: 20){
                Text(ue.model.nom ).bold().font(.caption).padding()
                Spacer()
                Text(ue.model.coef.description)
            }
            
       
            HStack(){
                Capsule().foregroundColor( ue.model.totalMoyenne * 5 < 50 ? .red : .green).frame(width: ue.model.totalMoyenne * 5 ,height: 22)
              Spacer()
                Text(ue.model.totalMoyenne.description)
                Spacer()
                NavigationLink(destination: UEPage(ue: ue)) {
                    Image(systemName:   "square.and.pencil")
                }
            }
            Divider()
            
            
        }.padding()
    }
}

struct UE_Previews: PreviewProvider {
    static var previews: some View {
        UE(ue: UeVM(withUe: Ue(code: "Projet", nom: "Projet", matieres: DataStub().loadMartiereUE6(),coef: 15)))
    }
}
