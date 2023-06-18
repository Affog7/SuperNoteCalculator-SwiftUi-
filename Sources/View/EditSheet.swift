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
                        Button(action: {
                            self.ue.onDeleted(matiere)
                        }){
                            Text("Supprimer")
                        }
                    } 
                          
        }
                    Spacer()
                    Button(action: {
                        self.ue.onAdding()
                    }) {
                        Text("Ajouter une matiere")
                    }
                }
            }.padding().background(NoteColor().ue_back)
            
        }
        .navigationBarItems(trailing:
        Button(action: {
            self.ue.onEdited()
        }) {
            Text( self.ue.isEditing ? "Done" : "Modifier")
        })
        
        // Feuille d'ajout
        .sheet(isPresented: $ue.isAdding){
            NavigationStack{
                
                AddSheet(mat: self.ue.addedItem ?? MatiereVM())
            
        .toolbar{
            ToolbarItem(id: "Ajouter", placement: .confirmationAction){
                Button(action: {
                    self.ue.onAdded()
                }){
                    Text("Add")
                }
            }
            ToolbarItem(id: "cancel", placement: .cancellationAction){
                Button(action: {
                    self.ue.onAdded(isCancelled: true)
                }){
                    Text("Cancel")
                }
            }
        }
        .navigationBarTitle("Ajout d'une nouvelle matière")
                    }
                }
        
    }}


struct EditSheet_Previews: PreviewProvider {
    static var previews: some View {
        let uevm : UeVM = UeVM(withUe: DataStub().ue_proj)
        EditSheet(ue: uevm, isEditMode: .constant(true))
    }
}
