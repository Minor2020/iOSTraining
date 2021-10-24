//
//  PageviewController.swift
//  Training
//
//  Created by Zhang,Yongchao(BAMRD) on 2021/10/24.
//

import SwiftUI
import UIKit

/**
 * PageViewController uses a UIPageViewController to show content from a SwiftUI view
 */
struct PageViewController<Page: View>: UIViewControllerRepresentable {
  
    
    var pages: [Page]
    @Binding var currentPage: Int
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        // 将coordinator 作为 data source
        pageViewController.dataSource = context.coordinator
        // 更新 binding 值 current page
        pageViewController.delegate = context.coordinator
        return pageViewController
    }
    
    /**
     * To provide a view controller for display.
     */
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
//             [UIHostingController(rootView: pages[0])],
            [context.coordinator.controllers[currentPage]],
            direction: .forward,
            animated: true)
    }
    
    /**
     * 可以通过该类实现 Cocoa 通用设计模块
     */
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        // 持有 controllers
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            // 用 pages 的 view 数组初始化 controllers
            controllers = parent.pages.map{ UIHostingController(rootView: $0) }
        }
        
        /**
         * viewControllerBefor 对应 swipe back
         */
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        
        /**
         * after 对应 swipe forth
         */
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController,
                                didFinishAnimating finished: Bool,
                                previousViewControllers: [UIViewController],
                                transitionCompleted completed: Bool) {
            // 这个表达式还挺有意思
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
            
        }
    }
}
