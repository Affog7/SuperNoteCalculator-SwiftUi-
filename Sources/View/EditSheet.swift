//
//  EditSheet.swift
//  Note
//
//  Created by etudiant on 14/06/2023.
//

import SwiftUI

struct EditSheet: View {
    @ObservedObject var ue: UeVM
    @Binding var isEditMode: Bool
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                Section(header: Text("UE Info").font(.title)) {
                    
                    
                    VStack{
                        TextField("Description", text: $ue.nom)
                        TextField("Coefficient", value: $ue.coef, format: .number)
                    }
                    
                    
                    
                }
                Divider()
                Section(header: Text("Matieres").font(.title)) {
                    ForEach(ue.someMatieresVM) { matiere in
                        HStack{
                            MatiereEditView(matiere:   matiere)
                            
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
        
        
    }}


struct EditSheet_Previews: PreviewProvider {
    static var previews: some View {
        let uevm : UeVM = UeVM(withUe: DataStub().ue_proj)
        EditSheet(ue: uevm, isEditMode: .constant(true))
    }
}
