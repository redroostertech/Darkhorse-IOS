//
//  UITableViewCell+Extensions.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/23/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

public extension UITableViewCell {
  static var nib: UINib? {
    return UINib(nibName: self.identifier, bundle: self.bundle)
  }
  
//  func getNib() -> UINib? {
//    let podBundle = Bundle(for: self)
//    guard let bundleURL = podBundle.url(forResource: "forcemaps-ios", withExtension: "bundle") else { return nil }
//    return UINib(nibName: String(describing: self), bundle: Bundle(url: bundleURL))
//  }
  
  func getIdentifier() -> String {
    return String(describing: self)
  }
  
  func hideView(usingConstraints constraints: [NSLayoutConstraint], onViews views: [UIView]) {
    for constraint in constraints {
      hideView(usingConstraint: constraint)
    }
    
    for view in views {
      view.isHidden = true
    }
  }
  
  func hideView(usingConstraint constraint: NSLayoutConstraint) {
    constraint.constant = .zero
  }
}
