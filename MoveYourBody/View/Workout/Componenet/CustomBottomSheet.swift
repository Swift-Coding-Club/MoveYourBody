//
//  CustomBottomSheet.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/26.
//

import SwiftUI

extension AnyTransition {
    static var moveFromBottom: AnyTransition {
        .move(edge: .bottom)
    }
}

struct CustomBottomSheet<Content> : View where Content : View {

    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
     
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: CardView())
    }
}

struct CardView: ViewModifier {
    @State private var dragging = false
    @GestureState private var dragTracker: CGSize = CGSize.zero
    @State private var position: CGFloat = UIScreen.main.bounds.height * 0.7
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .top) {
                Color("sheetBackground")
                RoundedRectangle(cornerRadius: 2.5)
                    .frame(width: 40, height: 5.0)
                    .foregroundColor(Color.secondary)
                    .padding(10)
                content
                    .padding(.top, 30)
            }
            .frame(minWidth: UIScreen.main.bounds.width)
            .scaleEffect(x: 1, y: 1, anchor: .center)
            .background(Color.white)
            .cornerRadius(35)
        }
        .offset(y:  max(0, position + self.dragTracker.height))
        .transition(.moveFromBottom)
        .gesture(DragGesture()
                    .updating($dragTracker) { drag, state, transaction in state = drag.translation }
                    .onChanged {_ in  dragging = true }
                    .onEnded(onDragEnded))
        .animation(.spring(), value: dragTracker)
        .onAppear {
            position = UIScreen.main.bounds.height * 0.7
        }
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        dragging = false
        let high = UIScreen.main.bounds.height * 0.1
        let low: CGFloat = UIScreen.main.bounds.height * 0.7
        let dragDirection = -(drag.predictedEndLocation.y - drag.location.y)
        print(UIScreen.main.bounds.height)
        print(dragDirection)
        //can also calculate drag offset to make it more rigid to shrink and expand
        if dragDirection > 0 {
            position = high
        } else {
            position = low
        }
    }
}
