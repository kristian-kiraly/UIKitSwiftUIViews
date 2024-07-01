# UIKitSwiftUIViews

A small package that allows encapsulation of SwiftUI views into UIKit containers like UIView and UIViewController.

Usage:

```swift
struct ContentView: View {
    var body: some View {
        Button("Hello") {
            let vc = SwiftUIViewController {
                Text("World")
            }
            AppDelegate.topViewController.present(vc, animated: true)
        }
    }
}

@objc class SomeSwiftUIViewController: SwiftUIViewController {
    init() {
        super.init {
            Text("SwiftUI accessible from Objective-c")
        }
    }
}

class StoryboardViewController: UIViewController {
    @IBOutlet var content: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(SwiftUIView {
            Text("SwiftUI injected into a storyboard's view")
        })
    }
}
```

