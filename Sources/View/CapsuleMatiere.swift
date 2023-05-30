import SwiftUI
import UIKit

import SwiftUI
import UIKit

 struct ExpandingCapsuleViewMatiere: View {
    @ObservedObject   var matiere : MatiereVM
      var islock : Bool = true
    @GestureState private var dragState = DragState.inactive
     @State private var capsuleWidth: CGFloat = 25.0
    private var widthMax = 100.0
    private var widthMin = 5.0
    private enum DragState {
        case inactive
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
    }
    
     
     init(mat: MatiereVM, islock : Bool = true) {
         self.matiere = mat
         self.islock = islock
        capsuleWidth = CGFloat(mat.model.moyenne) * 5
         //print(capsuleWidth/5)
     }
     
     var body: some View {
        let dragGesture = DragGesture()
             
            .onEnded { value in
                let dragThreshold: CGFloat = 0.50
                let dragTranslation = value.translation.width
                
                if CGFloat(matiere.model.moyenne)*5 <= 100 {
                    if dragTranslation > dragThreshold {
                        capsuleWidth += (dragTranslation  - dragThreshold)
                        updateMoy()
                       print(capsuleWidth/5)
                    } else if dragTranslation < -dragThreshold {
                        
                            capsuleWidth =  dragTranslation/5 - dragThreshold
                        updateMoy()
                    }
                }
                
            }
        
        return GeometryReader { geometry in
            Capsule()
                .frame(width: Double(matiere.model.moyenne * 5) >= widthMax ? 100.0 : CGFloat(matiere.model.moyenne) * 5 + 2 , height: 22)
                .foregroundColor(CGFloat(matiere.model.moyenne) * 5    < 50 ? .red : .green)
                .gesture( islock ? DragGesture().onEnded({_ in }) : dragGesture)
                .animation(.spring())
                .offset(x: dragState.translation.width, y: 0)
                .onAppear {
                    // Set initial capsule width
                    capsuleWidth = min(geometry.size.width, geometry.size.height)
                }
        }
    }
     
     
     private func updateMoy(){
         matiere.model.moyenne +=  Float(capsuleWidth)  / 5
         if matiere.model.moyenne > 20 { matiere.model.moyenne = 20 }
         if matiere.model.moyenne < 0 { matiere.model.moyenne = 0 }
     }
}




struct CapsuleMatiere_Previews: PreviewProvider {
    static var previews: some View {
        
        ExpandingCapsuleViewMatiere(mat:   MatiereVM(withMat: Matiere(name: "Projet", moy: 12, coef: 9)))
    }
}
