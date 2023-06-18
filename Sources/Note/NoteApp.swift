//
//  NoteApp.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

@main
struct NoteApp: App {
  var blocs = [
                        BlocVM(withBloc:     Bloc(nom: "Total", ues: DataStub().load(),isUq: false)),
                        BlocVM(withBloc:   Bloc(nom: "Projet/Stage", ues: DataStub().loadUeStage_Proj(), isUq: true))
    ]
    var body: some Scene {
        WindowGroup {
            Home(manager: ManagerVM( withBlocs: blocs
        ))
        }
    }
}
