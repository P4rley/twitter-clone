//
//  ToolbarScrollView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 23/04/24.
//

import SwiftUI

struct ToolbarScrollView<Content: View>: View {
    var axis: Axis.Set
    var showIndicator: Bool
    @Binding var tabState: Visibility
    var content: Content
        
    init(axis: Axis.Set, showIndicator: Bool, tabState: Binding<Visibility>, content: @escaping () -> Content) {
        self.axis = axis
        self.showIndicator = showIndicator
        self._tabState = tabState
        self.content = content()
    }
    
    
    var body: some View {
        if #available(iOS 17, *) {
            ScrollView(axis) {
                content
            }
            .scrollIndicators(showIndicator ? .visible : .hidden)
            .background {
                CustomGesture {
                    handleTabState($0)
                }
            }
        } else {
            ScrollView(axis, showsIndicators: showIndicator) {
                content
            }
            .background {
                CustomGesture {
                    handleTabState($0)
                }
            }

        }
    }
    
    func handleTabState(_ gesture: UIPanGestureRecognizer) {
        let offsetY = gesture.translation(in: gesture.view).y
        let velocityY = gesture.velocity(in: gesture.view).y
        
        if velocityY < 0 {
            if -(velocityY / 5) > 60 && tabState == .visible {
                tabState = .hidden
            }
        } else {
            if (velocityY / 5) > 40 && tabState == .hidden {
                tabState = .visible
            }
        }
    }
}

fileprivate struct CustomGesture: UIViewRepresentable {
    var onChange: (UIPanGestureRecognizer) -> ()
    
    private let gestureID = UUID().uuidString
    
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onChange: onChange)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let superView = uiView.superview?.superview, !(superView.gestureRecognizers?.contains(where: { $0.name == gestureID }) ?? false) {
                
                let gesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.gestureChange(gesture:)))
                    
                gesture.name = gestureID
                gesture.delegate = context.coordinator
                superView.addGestureRecognizer(gesture)
            }
        }
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var onChange: (UIPanGestureRecognizer) -> ()
        
        init(onChange: @escaping (UIPanGestureRecognizer) -> Void) {
            self.onChange = onChange
        }
        
        @objc
        func gestureChange(gesture: UIPanGestureRecognizer) {
            onChange(gesture)
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
}

#Preview {
    ContentView()
}
