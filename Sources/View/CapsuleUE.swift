import SwiftUI
import UIKit

import SwiftUI
import UIKit

 struct ExpandingCapsuleView: View {
    @ObservedObject   var ue : UeVM
    @GestureState private var dragState = DragState.inactive
    @State private var capsuleWidth: CGFloat = 5.0
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
    
     
     init(ue: UeVM) {
         self.ue = ue
       
     }
     
     var body: some View {
        let dragGesture = DragGesture()
             
            .onEnded { value in
                let dragThreshold: CGFloat = 1.005
                let dragTranslation = value.translation.width
                
                if dragTranslation > dragThreshold {
                    
               
                        capsuleWidth += dragTranslation - dragThreshold
                    updateMoy()
                    
                } else if dragTranslation < -dragThreshold {
                    
                        capsuleWidth -= abs(dragTranslation) - dragThreshold
                    updateMoy()
                }
            }
        
        return GeometryReader { geometry in
            Capsule()
                .frame(width: capsuleWidth >= widthMax ? 100.0 : capsuleWidth , height: 30)
                .foregroundColor(.blue)
                .gesture(dragGesture)
                .animation(.spring())
                .offset(x: dragState.translation.width, y: 0)
                .onAppear {
                    // Set initial capsule width
                    capsuleWidth = min(geometry.size.width, geometry.size.height)
                }
        }
    }
     
     
     private func updateMoy(){
         var da = ue.model.totalMoyenne * capsuleWidth / 100
         ue.model.coef = ue.model.coef + 1
         print(da)
     }
}




struct CapsuleV_Previews: PreviewProvider {
    static var previews: some View {
        
        
        ExpandingCapsuleView(ue : UeVM(withUe: Ue( nom: "UE 2", matieres: DataStub().loadMartiereUE2(),coef: 9)))
    }
}
