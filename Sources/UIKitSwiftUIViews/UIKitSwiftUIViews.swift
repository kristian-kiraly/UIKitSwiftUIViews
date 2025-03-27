// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public class SwiftUIViewController: UIViewController {
    public init<Content: View>(backgroundColor: UIColor? = nil, @ViewBuilder swiftUIView: @MainActor @escaping () -> Content) {
        super.init(nibName: nil, bundle: nil)
        loadSwiftUIView(backgroundColor: backgroundColor, swiftUIView: swiftUIView)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSwiftUIView<Content: View>(backgroundColor: UIColor?, @ViewBuilder swiftUIView: @MainActor @escaping () -> Content) {
        let vc = UIHostingController(rootView: swiftUIView())
        let uiView = vc.view!
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(vc)
        view.addSubview(uiView)
        if let backgroundColor {
            self.view.backgroundColor = backgroundColor
            uiView.backgroundColor = backgroundColor
        }
        
        NSLayoutConstraint.activate([
            uiView.topAnchor.constraint(equalTo: view.topAnchor),
            uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        vc.didMove(toParent: self)
        
        view.clipsToBounds = true
    }
}

public class SwiftUIView: UIView {
    public init<Content: View>(@ViewBuilder swiftUIView: @MainActor @escaping () -> Content) {
        super.init(frame: .zero)
        loadSwiftUIView(swiftUIView: swiftUIView)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSwiftUIView<Content: View>(@ViewBuilder swiftUIView: @MainActor @escaping () -> Content) {
        let view = swiftUIView()
        self.frame = .init(origin: .zero, size: view.viewSize)
        
        let hostingView = UIHostingController(rootView: view).view!
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(hostingView)
        
        NSLayoutConstraint.activate([
            hostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingView.topAnchor.constraint(equalTo: topAnchor),
            hostingView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        hostingView.isUserInteractionEnabled = true
    }
}

public extension View {
    var viewSize: CGSize {
        let hostingController = UIHostingController(rootView: self)
        return hostingController.view!.intrinsicContentSize
    }
}
