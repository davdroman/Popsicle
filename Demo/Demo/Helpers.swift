import UIKit

infix operator ..

extension UIView {
    convenience init(transform: (Self) -> Void) {
        self.init()
        transform(self)
    }
}

@discardableResult
func .. <View: UIView>(
    view: View,
    transform: (View) -> Void
) -> View {
    transform(view)
    return view
}

extension UIView {
    func pinToSuperviewEdges() {
        guard let superview else { return }

        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }
}
