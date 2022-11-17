import UIKit

infix operator =>

extension UIView {
    convenience init(transform: (UIView) -> Void) {
        self.init()
        transform(self)
    }

    static func => (
        view: UIView,
        transform: (UIView) -> Void
    ) -> UIView {
        transform(view)
        return view
    }
}
