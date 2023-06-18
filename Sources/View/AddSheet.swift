//
//  AddSheet.swift
//  Note
//
//  Created by etudiant on 18/06/2023.
//

import SwiftUI

struct AddSheet: View {
    @ObservedObject var mat : MatiereVM
    var body: some View {
        VStack{
            HStack{
                Text("Nom : ")
                TextField("Description", text: $mat.name)
             }
            HStack{
                Text("Coef : ")
                TextField("Coefficient", value: $mat.coef, format: .number)
                
            }
        }
        
    }
}

struct AddSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddSheet(mat: MatiereVM())
    }
}
