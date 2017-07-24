//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by Dmitriy Roytman on 24.07.17.
//  Copyright © 2017 raywenderlich. All rights reserved.
//

import UIKit

final class PhotoCommentViewController: UIViewController {
  // MARK: Outlets
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var textField: UITextField!
  
  // MARK: Action
  @IBAction func hideKeyboard() {
    textField.endEditing(true)
  }
  @IBAction func openZoomingController() {
    performSegue(withIdentifier: "zooming", sender: nil)
  }
  // MARK: public properties
  var photoName: String?
  var photoIndex: Int!
  
  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    guard let photoName = photoName else { return }
    imageView.image = UIImage(named: photoName)
  }
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier, identifier == "zooming", let destination = segue.destination as? ZoomedPhotoViewController else { return }
    destination.photoName = photoName
  }
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: selectors for keyboard show/hide notifications
  @objc func keyboardWillShow(_ notificarion: Notification) {
    adjustInsetForKeyboardShow(true, notification: notificarion)
  }
  @objc func keyboardWillHide(_ notification: Notification) {
    adjustInsetForKeyboardShow(false, notification: notification)
  }
  
  // MARK: Helper function
  private func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
    guard let frameValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
    let keyboardFrame = frameValue.cgRectValue
    let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
}
