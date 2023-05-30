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
    
    init(ue: UeVM) {
        self.ue = ue
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 20) {
                    Text(ue.model.nom)
                        .bold()
                        .font(.title)
                }
                Divider()
                HStack(spacing: 15) {
                    Capsule()
                        .foregroundColor(ue.model.totalMoyenne * 5 < 50 ? .red : .green)
                        .frame(width: ue.model.totalMoyenne * 5, height: 22)
                    Text(ue.model.coef.description)
                    Text(ue.model.totalMoyenne.description)
                }
                
                ScrollView {
                    ForEach(ue.model.matieres) { mat in
                        MatiereUI(matiere: MatiereVM(withMat: mat))
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
}

struct EditSheet: View {
    @ObservedObject var ue: UeVM
    @Binding var isEditMode: Bool
    @State private var coefficient: Double = 0.0
    
    var body: some View {
         
        NavigationView {
            
            VStack{
                Section(header: Text("UE Info").font(.title)) {
                    TextField("Description", text: $ue.model.nom)
                    TextField("Coefficient", value: $ue.model.coef, format: .number)
                                       
                                    }
                                    Divider()
                Section(header: Text("Matieres").font(.title)) {
                    ForEach(ue.model.matieres) { matiere in
                        HStack{
                            MatiereEditView(matiere: MatiereVM(withMat: matiere))
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
                TextField("Nom", text: $matiere.model.name)
                TextField("Coefficient", value: $matiere.model.coef, format: .number)
                Divider()
            }
        }
    }
}




struct UEPage_Previews: PreviewProvider {
    static var previews: some View {
        UEPage(ue: UeVM(withUe: Ue(code: "Projet", nom: "Projet", matieres: DataStub().loadMartiereUE6(),coef: 15)))
    }
}
