//
//  UIApplication+Extensions.swift
//  Rooted
//
//  Created by Michael Westbrooks on 10/13/20.
//  Copyright © 2020 RedRooster Technologies Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
  static var statusBarHeight: CGFloat {
    var statusBarHeight: CGFloat = 0
    if #available(iOS 13.0, *) {
      let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
      statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    else {
      statusBarHeight = UIApplication.shared.statusBarFrame.height
    }
    return statusBarHeight
  }
}
