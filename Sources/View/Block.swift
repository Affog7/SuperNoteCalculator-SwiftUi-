//
//  Block.swift
//  Note
//
//  Created by etudiant on 23/05/2023.
//

import SwiftUI

struct Block: View {
  
    @ObservedObject var manager : ManagerVM
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "menucard.fill")
                Text("Block").bold().font(.title)
            }
            Divider()
            ForEach(manager.blocs) { item in
                HStack(spacing: 15) {
                    Image(systemName: "rectangle.on.rectangle")
                    Text( item.nom).font(.title3)
                    Text( item.totalMoyenne.description)
                    
                    Image(systemName: "graduationcap.circle.fill")
                    
                }
                
                Divider()
            }
          /*  Button(action: {
                manager.blocs[0].someUesVM[0].someMatieresVM[0].moyenne += 3
                manager.blocs[0].someUesVM[0].totalMoyenne = manager.blocs[0].someUesVM[0].updateTotalMoyenne()
                manager.blocs[0].totalMoyenne = manager.blocs[0].updateTotalMoyenne()
                print(manager.blocs[0].totalMoyenne)
            } ){
                Text("zsdfghjk")
            } */
        }
    }
}
struct Block_Previews: PreviewProvider {
    static var previews: some View {
        let blocs =  [
 BlocVM(withBloc: Bloc(nom: "Total", ues:DataStub().load())),
BlocVM(withBloc: Bloc(nom: "Projet", ues: DataStub().loadUeStage_Proj()))]
  
                              Block(manager: ManagerVM(withBlocs: blocs) )
        
    }
}
