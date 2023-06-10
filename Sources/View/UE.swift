//
//  UE.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

public struct UE: View {
   @ObservedObject var ue : UeVM
    public var body: some View {
        
        VStack(alignment:.leading){
            Divider()
            HStack(spacing: 20){
                Text(ue.nom ).bold().font(.caption).padding()
                Spacer()
                Text(ue.coef.description)
            }
            
       
            HStack(){
                Capsule().foregroundColor( ue.totalMoyenne * 5 < 50 ? .red : .green).frame(width: ue.totalMoyenne * 5 ,height: 22)
              Spacer()
                Text(ue.totalMoyenne.description)
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
       
            let ue =  DataStub().load()[0]
            let ueVM = UeVM(withUe: ue)
            
            UE(ue: ueVM)
        }
   
}
