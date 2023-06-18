//
//  BlockItem.swift
//  Note
//
//  Created by etudiant on 18/06/2023.
//

import SwiftUI

struct BlockItem: View {
    @Binding var total : Double
    @Binding var name : String

    var body: some View {
        HStack(spacing: 15) {
            Grid{
                GridRow {
                    Image(systemName: "rectangle.on.rectangle")
                    Text(self.name).font(.title3)
                    Text( self.total,format: .number)
                    
                    Image(systemName: "graduationcap.circle.fill")
                        
                }
            }
           
            
        }
    }
}

struct BlockItem_Previews: PreviewProvider {
    static var previews: some View {
        BlockItem(total: .constant( 12.9), name: .constant( "Total"))
    }
}
