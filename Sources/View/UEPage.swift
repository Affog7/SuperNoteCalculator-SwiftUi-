//
//  UEPage.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

struct UEPage: View {
    @ObservedObject var ue: UeVM
    @ObservedObject var bloc: BlocVM
    

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
                    ForEach(ue.someMatieresVM) { mat in
                        MatiereUI(matiere: mat, ue : ue, bloc : bloc, islocked: true)
                    }
                }
            }
            
        }
        .navigationBarItems(trailing:
        Button(action: {
           
            if self.bloc.isEditing {

                self.bloc.onEdited(isCancelled: false)
                print("blocc \(self.bloc.totalMoyenne)")

            } else {
                
                self.ue.onEditing()
                self.bloc.onEditing()
                
            }

        }) {
            Text( self.bloc.isEditing ? "Done" : "Modifier")
        })
        .sheet(isPresented: $ue.isEditing) {
            EditSheet(ue: ue, isEditMode: $ue.isAdding)
              
        }
        
    }
}






struct UEPage_Previews: PreviewProvider {
    static var previews: some View {
        
        UEPage(
            ue: UeVM(withUe: Ue( nom: "Projet", matieres: DataStub().loadMartiereUE6(),coef: 15)),
            bloc: BlocVM(withBloc: Bloc(nom: "", ues: DataStub().loadUeStage_Proj(), isUq: true))
        )
    }
}
