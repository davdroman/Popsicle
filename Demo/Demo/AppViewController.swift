import Popsicle
import UIKit

final class AppViewController: UIViewController, UIScrollViewDelegate {

    let interpolator = Interpolator()

    override func viewDidLoad() {
        super.viewDidLoad()

        PageScrollView(interpolator: interpolator) .. {
            $0.delegate = self
            view.addSubview($0)
            $0.pinToSuperviewEdges()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        interpolator(0)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        interpolator(scrollView.contentOffset.x / scrollView.frame.width)
    }
}
