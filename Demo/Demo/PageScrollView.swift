import Popsicle
import UIKit

final class PageScrollView: DRPageScrollView {
    init(interpolator: Interpolator) {
        super.init(frame: .zero)

        let firstPageView = FirstPageView(in: self, interpolator: interpolator)
        let secondPageView = SecondPageView(in: self, interpolator: interpolator)
        let thirdPageView = ThirdPageView(in: self, interpolator: interpolator)
        let fourthPageView = FourthPageView(in: self, interpolator: interpolator)

        for page in [firstPageView, secondPageView, thirdPageView, fourthPageView] {
            self.addPage { view in
                view.addSubview(page)
                page.pinToSuperviewEdges()
            }
        }
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError() }
}

class PageView: UIView {
    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError() }
}

final class FirstPageView: PageView {
    init(in scrollView: PageScrollView, interpolator: Interpolator) {
        super.init()

        let image = UIImage(named: "popsicle")!
        let popsicle = UIImageView(image: image) .. {
            $0.contentMode = .scaleAspectFit
            $0.frame.size = .init(width: image.size.width / 1.5, height: image.size.height / 1.5)
        }
        addSubview(popsicle)

        interpolator.addKeyframe(0) {
            scrollView.backgroundColor = .white
            popsicle.center = self.center
        }
    }
}

final class SecondPageView: PageView {
    init(in scrollView: PageScrollView, interpolator: Interpolator) {
        super.init()

        interpolator.addKeyframe(1) {
            scrollView.backgroundColor = .purple
        }
    }
}

final class ThirdPageView: PageView {
    init(in scrollView: PageScrollView, interpolator: Interpolator) {
        super.init()

        interpolator.addKeyframe(2) {
            scrollView.backgroundColor = .green
        }
    }
}

final class FourthPageView: PageView {
    init(in scrollView: PageScrollView, interpolator: Interpolator) {
        super.init()

        interpolator.addKeyframe(3) {
            scrollView.backgroundColor = .red
        }
    }
}
