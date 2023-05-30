//
//  Home.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

struct Home: View {
   // @State public var ues  = DataStub().load()
    @ObservedObject  var uesM : UeCollectionVM
    var body: some View {
        NavigationView{
             
           VStack(alignment : .leading){
                    // Block
                    
                Block(blocks: [Bloc(nom: "Total", ues: DataStub().load()), Bloc(nom: "Stage/Projet", ues: DataStub().loadUeStage_Proj()) ]
                )
                
               VStack(alignment : .leading){
                   HStack(alignment:.bottom){
                       Image(systemName: "menucard.fill")
                       Text("UEs").bold().font(.title)
                   }.padding()
                       
                       ScrollView{
                           //UE
                           
                           ForEach(uesM.model.ues) { item in
                          
                               UE(ue: UeVM(withUe: item))
                              
                           }
                           
                       }
               }.padding().background(NoteColor().ue_back).cornerRadius(10)
                
                
                }.padding()
                
                 
        }
        

       
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(uesM: UeCollectionVM(withUe: UeCollection(nom: "fzf", ues: DataStub().load())) )
    }
}
