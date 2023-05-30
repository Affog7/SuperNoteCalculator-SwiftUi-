//
//  Block.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

struct Block: View {
    var blocks : [Bloc]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "menucard.fill")
                Text("Block").bold().font(.title)
            }
            Divider()
            ForEach(blocks) { block in
                HStack(spacing: 15) {
                    Image(systemName: "rectangle.on.rectangle")
                    Text(block.nom).font(.title3)
                    Text(block.total.description)
                    Image(systemName: "graduationcap.circle.fill")
                }
            }
            Divider()
        }
        .padding()
        .background(NoteColor().ue_back)
        .cornerRadius(10) // Appliquer le coin arrondi

    }
}
struct Block_Previews: PreviewProvider {
    static var previews: some View {
        Block(blocks: [Bloc(nom: "Total", ues: DataStub().load()), Bloc(nom: "Stage/Projet", ues: DataStub().loadUeStage_Proj()) ]
        )
    }
}
