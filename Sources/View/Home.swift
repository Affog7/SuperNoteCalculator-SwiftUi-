//
//  Home.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

struct Home: View {
   // @State public var ues  = DataStub().load()
    @StateObject  var manager: ManagerVM
    var body: some View {
        NavigationView{
             
           VStack(alignment : .leading){
                    // Block
                Block(manager: manager )
 
                
               VStack(alignment : .leading){
                   HStack(alignment:.bottom){
                       Image(systemName: "menucard.fill")
                       Text("UEs").bold().font(.title)
                   }.padding()
                       
                       ScrollView{
                           //UE
                           
                           ForEach(manager.blocs) { item in
                                ForEach(item.someUesVM) {
                                   ue in
                               
                                   UE(bloc: item, ue:  ue)
                               }
                               
                              
                              
                           }
                           
                       }
               }.padding().background(NoteColor().ue_back).cornerRadius(10)
                
                
                }.padding()
                
                 
        }
       
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        let managerVM = ManagerVM(withBlocs: [BlocVM(withBloc: Bloc(nom: "Total", ues: DataStub().load())),BlocVM(withBloc: Bloc(nom: "Projet", ues: DataStub().loadUeStage_Proj()))])
        Home(manager: managerVM )
    }
}
