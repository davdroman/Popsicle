import Popsicle
import UIKit

final class AppViewController: UIViewController, UIScrollViewDelegate {

//    let pageScrollView: PageScrollView
//    let interpolator: Interpolator

//    let animator = UIViewPropertyAnimator(duration: .zero, curve: .linear)
    let interpolator = Interpolator()
    let square = UIView {
        $0.backgroundColor = .blue
        $0.frame.size = .init(width: 100, height: 100)
    }
    let pagingView = DRPageScrollView()

    init() {
//        self.pageScrollView = PageScrollView(frame: CGRectZero)
//        self.interpolator = Interpolator()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pagingView.addPage { view in
//            view?.backgroundColor = .green
        }
        pagingView.addPage { view in
//            view?.backgroundColor = .purple
        }
        pagingView.addPage { view in
//            view?.backgroundColor = .purple
        }
        pagingView.delegate = self
        pagingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pagingView)
        NSLayoutConstraint.activate([
            pagingView.topAnchor.constraint(equalTo: view.topAnchor),
            pagingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        square.center = view.center
        view.addSubview(square)

//        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
//        view.addGestureRecognizer(pan)

        interpolator.setKeyframe(0) {
            self.pagingView.backgroundColor = .orange
        }

        interpolator.setKeyframe(1) {
            self.pagingView.backgroundColor = .green
        }

        interpolator.setKeyframe(2) {
            self.pagingView.backgroundColor = .purple
        }

//        animator.addAnimations {
//            self.square.center.x = 0
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        animator.startAnimation()
//        animator.pauseAnimation()

//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.animator.fractionComplete = 0.5
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                self.animator.fractionComplete = 0.75
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                self.animator.fractionComplete = 1
//            }
//        }
    }

    @objc private func handlePan(_ pan: UIPanGestureRecognizer) {
//        let translation = pan.translation(in: pan.view)
//        let x = translation.x
//        let fraction = x / view.frame.size.width
//        print(fraction)

    }

    @objc private func handleTap() {
//        animator.stopAnimation(true)
//        animator.startAnimation()
//        animator.pauseAnimation()
//        animator.continueAnimation(withTimingParameters: nil, durationFactor: 1)
//        square.center.x = .random(in: 40...320)
//        square.center.y = .random(in: 40...600)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x / scrollView.frame.width)
        let time = scrollView.contentOffset.x / scrollView.frame.width
//        print(time)
        interpolator.time = time
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        self.interpolator.removeAllInterpolations()
//
//        let backgroundColorInterpolation = Interpolation(self.view, backgroundColor)
//        backgroundColorInterpolation[1, 3] = UIColor.whiteColor()
//        backgroundColorInterpolation[1.7, 2] = UIColor(red: 254/255, green: 134/255, blue: 44/255, alpha: 1)
//        self.interpolator.addInterpolation(backgroundColorInterpolation)
//
//        let barTintColorInterpolation = Interpolation(self.navigationController!.navigationBar, barTintColor)
//        barTintColorInterpolation[1, 3] = UIColor.whiteColor()
//        barTintColorInterpolation[1.7, 2] = UIColor(red: 244255, green: 219/255, blue: 165/255, alpha: 1)
//        self.interpolator.addInterpolation(barTintColorInterpolation)
//
//        if let imageView = self.pageScrollView.firstPageView.imageView {
//            let xInterpolation = Interpolation(imageView, centerXConstraint)
//            xInterpolation[0] = 0
//            xInterpolation.setEasingFunction(EasingFunctionEaseInQuad, forTime: 0)
//            xInterpolation[1] = -self.pageScrollView.frame.width
//            xInterpolation[2] = -self.pageScrollView.frame.width*2
//            xInterpolation[3] = -self.pageScrollView.frame.width*3
//            self.interpolator.addInterpolation(xInterpolation)
//
//            let yInterpolation = Interpolation(imageView, centerYConstraint)
//            yInterpolation[0] = 0
//            yInterpolation[1, 2] = -self.pageScrollView.frame.height/2+80
//            yInterpolation[3] = 0
//            self.interpolator.addInterpolation(yInterpolation)
//
//            let alphaInterpolation = Interpolation(imageView, alpha)
//            alphaInterpolation[1] = 1
//            alphaInterpolation[2] = 0
//            alphaInterpolation[3] = 0.25
//            self.interpolator.addInterpolation(alphaInterpolation)
//
//            let transformInterpolation = Interpolation(imageView, transform)
//            transformInterpolation[0, 1, 2] = CGAffineTransformIdentity
//            transformInterpolation[0.25] = CGAffineTransformMake(0, 0, 1.1, 1.1, 0)
//            transformInterpolation[3] = CGAffineTransformMake(0, 0, 1.4, 1.4, 60)
//            self.interpolator.addInterpolation(transformInterpolation)
//        }
//
//        if let label1 = self.pageScrollView.firstPageView.label {
//            let alphaInterpolation = Interpolation(label1, alpha)
//            alphaInterpolation[0] = 1
//            alphaInterpolation[0.4] = 0
//            self.interpolator.addInterpolation(alphaInterpolation)
//        }
//
//        if let label2 = self.pageScrollView.secondPageView.label {
//            let scaleInterpolation = Interpolation(label2, transform)
//            scaleInterpolation[0] = CGAffineTransformMake(0, 0, 0.6, 0.6, 0)
//            scaleInterpolation[1] = CGAffineTransformMake(0, 0, 1, 1, 0)
//            self.interpolator.addInterpolation(scaleInterpolation)
//
//            let alphaInterpolation = Interpolation(label2, alpha)
//            alphaInterpolation[1] = 1
//            alphaInterpolation[1.7] = 0
//            self.interpolator.addInterpolation(alphaInterpolation)
//        }
//
//        if let label3 = self.pageScrollView.thirdPageView.label1, let label4 = self.pageScrollView.thirdPageView.label2 {
//            let translateInterpolation1 = Interpolation(label3, transform)
//            translateInterpolation1[1] = CGAffineTransformMake(100, 0, 1, 1, 0)
//            translateInterpolation1[2] = CGAffineTransformIdentity
//            translateInterpolation1[3] = CGAffineTransformMake(-100, 0, 1, 1, 0)
//            self.interpolator.addInterpolation(translateInterpolation1)
//
//            let translateInterpolation2 = Interpolation(label4, transform)
//            translateInterpolation2[1] = CGAffineTransformMake(300, 0, 1, 1, 0)
//            translateInterpolation2[2] = CGAffineTransformIdentity
//            translateInterpolation2[3] = CGAffineTransformMake(-300, 0, 1, 1, 0)
//            self.interpolator.addInterpolation(translateInterpolation2)
//        }
//    }
//
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        self.interpolator.time = Double(scrollView.contentOffset.x/scrollView.frame.size.width)
//    }
}
