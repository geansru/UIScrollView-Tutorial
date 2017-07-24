//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by Dmitriy Roytman on 24.07.17.
//  Copyright © 2017 raywenderlich. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
    // MARK: Data source
    private var photos: [UIImage] = [#imageLiteral(resourceName: "photo1"), #imageLiteral(resourceName: "photo2"), #imageLiteral(resourceName: "photo3"), #imageLiteral(resourceName: "photo4"), #imageLiteral(resourceName: "photo5")]
    var currentIndex = 0
  
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewController = viewPhotoCommentController(index: currentIndex)  else { return }
        setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
        dataSource = self
    }
  
  fileprivate func viewPhotoCommentController(index: Int) -> PhotoCommentViewController? {
    guard let storyboard = storyboard else { return nil }
    let page = storyboard.instantiateViewController(withIdentifier: "PhotoCommentViewController") as! PhotoCommentViewController
    page.photoIndex = index
    page.photoName = "photo\(index + 1)"
    return page
  }
}
extension ManagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      guard let viewController = viewController as? PhotoCommentViewController, let index = viewController.photoIndex, index > 0 else { return nil }
      return viewPhotoCommentController(index: index - 1)
    }
  
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
      guard let viewController = viewController as? PhotoCommentViewController, let index = viewController.photoIndex, (index + 1) < photos.count else { return nil }
      return viewPhotoCommentController(index: index + 1)
    }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return photos.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return currentIndex
  }
  
}
