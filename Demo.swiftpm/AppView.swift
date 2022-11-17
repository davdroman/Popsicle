import SwiftUI

struct AppView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        AppViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
