//
//  OnboardingPageViewController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/27.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {

    let introList = IntroScene.allCases
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6

        delegate = self
        dataSource = self
        
        setViewControllers([createOnboardingVC(index: 0)], direction: .forward, animated: true)
        
        setPageControlColor()
    }
    
    // MARK: - Helpers
    
    func createOnboardingVC(index: Int) -> UIViewController {
        let vc = OnboardingViewController()
        vc.introNumber = IntroScene(rawValue: index)
        
        return vc
    }
    
    func setPageControlColor() {
        UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingPageViewController.self]).currentPageIndicatorTintColor = .darkGray
        UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingPageViewController.self]).pageIndicatorTintColor = .systemGray4
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? OnboardingViewController else { return nil }
        guard let currentIndex = vc.introNumber?.rawValue else { return nil }
        
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : createOnboardingVC(index: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? OnboardingViewController else { return nil }
        guard let currentIndex = vc.introNumber?.rawValue else { return nil }
        
        let nextIndex = currentIndex + 1
        
        return nextIndex >= introList.count ? nil : createOnboardingVC(index: nextIndex)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return introList.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        guard let first = viewControllers?.first as? OnboardingViewController else { return 0 }
        guard let index = first.introNumber?.rawValue else { return 0 }
        
        return index
    }
}
