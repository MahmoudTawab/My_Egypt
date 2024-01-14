//
//  ScreenPageView.swift
//  Controllers
//
//  Created by Emojiios on 31/08/2022.
//

import UIKit

class ScreenPageView : UIPageViewController, UIScrollViewDelegate {
    
    var tutorialDelegate: TutorialPageViewControllerDelegate?
    
    var currentIndex = Int()
    let Page1 = WelcomeVC()
    let Page2 = WelcomeVC()
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [Page1,
                Page2]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    
        Page1.currentPage = 0
        Page2.currentPage = 1

        dataSource = self
        delegate = self
        
        view.subviews.forEach { sv in
        if let scrollView = sv as? UIScrollView {
        scrollView.delegate = self
        scrollView.isScrollEnabled = false
        }
        }
        
        if let initialViewController = orderedViewControllers.first {
        scrollToViewController(viewController: initialViewController)
        }
        
        tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self, didUpdatePageCount: orderedViewControllers.count)
    
        view.addSubview(ViewDismiss)
        ViewDismiss.frame = CGRect(x: ControlY(20), y: ControlY(40), width: view.frame.width - ControlY(40), height: ControlWidth(40))
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
    if currentIndex == 0, scrollView.contentOffset.x + scrollView.contentInset.left < 0 {
    scrollView.contentOffset = CGPoint(x: -scrollView.contentInset.left, y: scrollView.contentOffset.y)
    }
    else if currentIndex == orderedViewControllers.count - 1, scrollView.contentInset.right < 0, scrollView.contentOffset.x + scrollView.contentInset.right > 0 {
    scrollView.contentOffset = CGPoint(x: -scrollView.contentInset.right, y: scrollView.contentOffset.y)
    }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if currentIndex == 0, scrollView.contentOffset.x + scrollView.contentInset.left < 0 {
    targetContentOffset.pointee = CGPoint(x: -scrollView.contentInset.left, y: targetContentOffset.pointee.y)
    }
    else if currentIndex == orderedViewControllers.count - 1, scrollView.contentInset.right < 0, scrollView.contentOffset.x + scrollView.contentInset.right > 0 {
    targetContentOffset.pointee = CGPoint(x: -scrollView.contentInset.right, y: targetContentOffset.pointee.y)
    }
    }
    
    
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.IconSize = CGSize(width: ControlWidth(25), height: ControlWidth(25))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }

    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(viewController: nextViewController)
        }
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.firstIndex(of: firstViewController) {
            
            let ForwardDirectionByLang: UIPageViewController.NavigationDirection = "lang".localizable == "ar" ? .reverse : .forward
            let ReverseDirectionByLang: UIPageViewController.NavigationDirection = "lang".localizable == "ar" ? .forward : .reverse
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? ForwardDirectionByLang : ReverseDirectionByLang
                let nextViewController = orderedViewControllers[newIndex]
                scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }
    
    
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewController.NavigationDirection = .forward) {
        setViewControllers([viewController],
            direction: direction,
            animated: true,
            completion: { (finished) -> Void in
                // Setting the view controller programmatically does not fire
                // any delegate methods, so we have to manually notify the
                // 'tutorialDelegate' of the new index.
                self.notifyTutorialDelegateOfNewIndex()
        })
    }
    
    /**
     Notifies '_tutorialDelegate' that the current page index was updated.
     */
    private func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first as? WelcomeVC,
            let index = orderedViewControllers.firstIndex(of: firstViewController) {
            
            currentIndex = index
            firstViewController.tutorialPageViewController = self
            tutorialDelegate?.tutorialPageViewController(tutorialPageViewController: self, didUpdatePageIndex: index)
        }
    }
    
}

// MARK: UIPageViewControllerDataSource
extension ScreenPageView: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        

        
            guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
                return nil
            }
        
            let previousIndex = viewControllerIndex - 1
            
            // User is on the first view controller and swiped left to loop to
        
            // the last view controller.
//            guard previousIndex >= 0 else {
//                return orderedViewControllers.last
//            }
        
            guard previousIndex >= 0 else {
            return nil
            }
            
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
                return nil
            }
        
//            if let Controller = orderedViewControllers[viewControllerIndex] as? WelcomeScreen {
//            if viewControllerIndex == 1 && Controller.CheckboxButton.Button.tag != 1 {
//            Controller.CheckboxButton.Shake()
//            return nil
//            }
//            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
//            // User is on the last view controller and swiped right to loop to
//            // the first view controller.
//            guard orderedViewControllersCount != nextIndex else {
//                return orderedViewControllers.first
//            }
        
            guard orderedViewControllersCount != nextIndex else {
            return nil
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
    }
    
}

extension ScreenPageView: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
    
}

protocol TutorialPageViewControllerDelegate {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func tutorialPageViewController(tutorialPageViewController: ScreenPageView,
        didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tutorialPageViewController(tutorialPageViewController: ScreenPageView,
        didUpdatePageIndex index: Int)
    
    
}



