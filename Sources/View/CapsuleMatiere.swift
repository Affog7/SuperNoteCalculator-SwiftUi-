import SwiftUI
import UIKit

 

 struct ExpandingCapsuleViewMatiere: View {
    @ObservedObject    var matiere : MatiereVM
     @ObservedObject   var ue : UeVM
     @ObservedObject   var bloc : BlocVM
      var islock : Bool = true
    @GestureState private var dragState = DragState.inactive
     @State private var capsuleWidth: CGFloat = 25.0
      var widthMax = 100.0
      var widthMin = 5.0
      enum DragState {
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
    
     
     
     
     public var body: some View {
        let dragGesture = DragGesture()
             
            .onEnded { value in
                let dragThreshold: CGFloat = 0.02
                let dragTranslation = value.translation.width
                
                if CGFloat(matiere.moyenne)*5 <= 100 {
                    if dragTranslation > dragThreshold {
                        capsuleWidth += (dragTranslation  - dragThreshold)
                        updateMoy()
                      // print(capsuleWidth/5)
                    } else if dragTranslation < -dragThreshold {
                        
                            capsuleWidth =  dragTranslation/5 - dragThreshold
                        updateMoy()
                    }
                }
                
            }
        
        return GeometryReader { geometry in
            Capsule()
                .frame(width: Double(matiere.moyenne * 5) >= widthMax ? 100.0 : CGFloat(matiere.moyenne) * 5 + 2 , height: 22)
                .foregroundColor(CGFloat(matiere.moyenne) * 5    < 50 ? .red : .green)
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
         self.matiere.moyenne +=  Float(capsuleWidth)  / 5
         if matiere.moyenne > 20 { matiere.moyenne = 20 }
         if matiere.moyenne < 0 { matiere.moyenne = 0 }
         ue.totalMoyenne = ue.updateTotalMoyenne()
         bloc.totalMoyenne = bloc.updateTotalMoyenne()
      
         
         
         print(bloc.nom)
     }
}




struct CapsuleMatiere_Previews: PreviewProvider {
    static var previews: some View {
        
        ExpandingCapsuleViewMatiere(matiere: MatiereVM(withMat: Matiere(name: "Projet", moy: 12, coef: 9)),ue: UeVM(withUe: DataStub().loadUeStage_Proj()[0]),
                                    bloc: BlocVM(withBloc: Bloc(nom: "", ues: DataStub().loadUeStage_Proj())) )
    }
}
