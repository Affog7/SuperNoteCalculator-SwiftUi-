//
//  NoteApp.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

@main
struct NoteApp: App {
    let manager = BlocManager()
    var blocs : [BlocVM] = []
   /* var blocs = [
                          BlocVM(withBloc:     Bloc(nom: "Total", ues: DataStub().load(),isUq: false)),
                          BlocVM(withBloc:   Bloc(nom: "Projet/Stage", ues: DataStub().loadUeStage_Proj(), isUq: true))
      ]*/
    init(){
        do {
            try  self.manager.loadFromCSVFile()
            
            
            let allBlocs = manager.getAllBlocs()
            
         //   try self.manager.saveToCSVFile(at: "/Users/auaffognon/Downloads/Archive/Sources/blocs.csv", bloc: Bloc(nom: "Projet/Stage", ues: DataStub().loadUeStage_Proj(), isUq: true))
            for blc in allBlocs {
                if !allBlocs.isEmpty { blocs.append(BlocVM(withBloc: blc)) }
            }
            print(allBlocs.count)
        } catch {
            print("Error saving blocs to CSV file: \(error)")
        }
    }
   

    

    var body: some Scene {
        WindowGroup {
            Home(manager: ManagerVM( withBlocs: blocs
        ))
        }
    }
}
