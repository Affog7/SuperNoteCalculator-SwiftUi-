//
//  NoteApp.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

@main
struct NoteApp: App {
    @StateObject var ues : UeCollectionVM =  UeCollectionVM(withUe:  UeCollection(nom: "First", ues: DataStub().load()));
    
    var body: some Scene {
        WindowGroup {
            Home(uesM: ues)
        }
    }
}
