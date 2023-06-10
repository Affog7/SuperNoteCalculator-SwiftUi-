//
//  UEPage.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

struct UEPage: View {
    @ObservedObject var ue: UeVM
    @State private var isEditMode = false
    @State private var showEditSheet = false
    
     
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 20) {
                    Text(ue.nom)
                        .bold()
                        .font(.title)
                }
                Divider()
                HStack(spacing: 15) {
                    Capsule()
                        .foregroundColor(ue.totalMoyenne * 5 < 50 ? .red : .green)
                        .frame(width: ue.totalMoyenne * 5, height: 22)
                    Text(ue.coef.description)
                    Text(ue.totalMoyenne.description)
                }
                
                ScrollView {
                    ForEach($ue.someMatieresVM) { $mat in
                        MatiereUI(matiere: mat, ue : ue, islocked: true)
                    }
                }
            }
            
        }
        .navigationBarItems(trailing: Button(action: {
            showEditSheet = true
        }) {
            Text("Edit")
        })
        .sheet(isPresented: $showEditSheet) {
            EditSheet(ue: ue, isEditMode: $isEditMode)
        }
    }
}

struct EditSheet: View {
    @ObservedObject var ue: UeVM
    @Binding var isEditMode: Bool
    @State private var coefficient: Double = 0.0
    
    var body: some View {
         
        NavigationView {
            
            VStack{
                Section(header: Text("UE Info").font(.title)) {
                    TextField("Description", text: $ue.nom)
                    TextField("Coefficient", value: $ue.coef, format: .number)
                                       
                                    }
                                    Divider()
                Section(header: Text("Matieres").font(.title)) {
                    ForEach(ue.someMatieresVM) { matiere in
                        HStack{
                            MatiereEditView(matiere:   matiere)
                            Button(action: {
                                // Ajouter une matiere
                            }) {
                                Text("Supprimer")
                            }
                        }
                       
                       
                    }
                    Spacer()
                    Button(action: {
                        // Ajouter une matiere
                    }) {
                        Text("Ajouter une matiere")
                    }
                }
            }.padding().background(NoteColor().ue_back)
            
        }
        .navigationBarItems(trailing: Button(action: {
            isEditMode = false
        }) {
            Text("Done")
        })
        
        
    }
    
    struct MatiereEditView: View {
        @ObservedObject var matiere: MatiereVM
        
        var body: some View {
            VStack {
                TextField("Nom", text: $matiere.name)
                TextField("Coefficient", value: $matiere.coef, format: .number)
                Divider()
            }
        }
    }
}




struct UEPage_Previews: PreviewProvider {
    static var previews: some View {
        
        UEPage(ue: UeVM(withUe: Ue( nom: "Projet", matieres: DataStub().loadMartiereUE6(),coef: 15)))
    }
}
