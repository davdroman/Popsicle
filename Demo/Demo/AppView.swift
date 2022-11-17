import SwiftUI

struct AppView: View {
    var body: some View {
        Content().edgesIgnoringSafeArea(.all)
    }
}

extension AppView {
    struct Content: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            AppViewController()
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
