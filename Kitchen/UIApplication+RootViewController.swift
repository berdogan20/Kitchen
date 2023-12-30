//
//  UIApplication+RootViewController.swift
//  Kitchen
//
//  Created by beyza erdoğan on 30.12.2023.
//

import Foundation
import UIKit

extension UIApplication {
  var currentKeyWindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .compactMap { ($0 as? UIWindowScene)?.keyWindow }
      .first
  }

  var rootViewController: UIViewController? {
    currentKeyWindow?.rootViewController
  }
}
