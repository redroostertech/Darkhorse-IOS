//
//  Configuration.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/18/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Core
public let kAppName = "Darkhorse"
public let kGroupName = "com.nuracode.darkhorse.Darkhorse-iOS"

// MARK: - Networking
public let kPagination : UInt = 10
public let kMaxConcurrentImageDownloads = 2
public var isDebug = true
public let kLocalBaseURL = ""
public let kTestBaseURL = ""
public let kLiveBaseURL = ""

// MARK :- UI + Sizes
public let kJPEGImageQuality : CGFloat = 0.4
public let kIconSizeWidth : CGFloat = 32
public let kIconSizeHeight : CGFloat = 32
public let kPhotoShadowRadius : CGFloat = 10.0
public let kPhotoShadowColor : UIColor = UIColor(white: 0,
                                                 alpha: 0.1)
public let kProfilePhotoSize : CGFloat = 100
public let kTopOfScreen = UIScreen.main.bounds.minY
public let kBottomOfScreen = UIScreen.main.bounds.maxY
public let kFarLeftOfScreen = UIScreen.main.bounds.minX
public let kFarRightOfScreen = UIScreen.main.bounds.maxX
public let kWidthOfScreen = UIScreen.main.bounds.width
public let kHeightOfScreen = UIScreen.main.bounds.height
public let kSearchTextFieldHeight: CGFloat = 42
public let kContainerViewHeightForMyPicks: CGFloat = 225
public let kRemainingHeightForContainer: CGFloat = 250
public let kAnimationDuration: Double = 2.0
public let kPrimarySpacing: CGFloat = 8.0
public let kPrimaryNoSpacing: CGFloat = 0.0
public let kPrimaryCellHeight: CGFloat = 200.0
public let kBarBtnSize = CGSize(width: 32.0,
                                height: 32.0)
public let kBarBtnPoint = CGPoint(x: 0.0,
                                  y: 0.0)
public let kTextFieldPadding: CGFloat = 10.0
public let kTextFieldIndent: CGFloat = 16.0
public let kButtonRadius: CGFloat = 15.0

//  MARK:- UI + Colors
public let kEnabledTextColor: UIColor = .darkText
public let kDisabledTextColor: UIColor = .gray

//  MARK:- UI + Fonts
public let kFontTitle = ""
public let kFontSubHeader = ""
public let kFontMenu = ""
public let kFontBody = ""
public let kFontCaption = ""
public let kFontButton = ""
public var kFontSizeTitle: CGFloat {
  return 28
}
public var kFontSizeSubHeader: CGFloat {
  return 24
}
public var kFontSizeMenu: CGFloat {
  return 18
}
public var kFontSizeBody: CGFloat {
  return 18
}
public var kFontSizeCaption: CGFloat {
  return 12
}
public var kFontSizeButton: CGFloat {
  return 16
}

//  MARK:- UI + Strings
let kBackText = "Back"

// MARK:- Observer Keys

// MARK: - UserDefaults Keys
public let kAuthIsLoggedIn = "isUserLoggedIn"

// MARK: - Storyboard
public let kStoryboardMain = "Main"

// MARK: - ViewControllers

// MARK: - Segues

// MARK: - User Experience Strings

// MARK: - NotificationCenter Methods
public let kNotificationKeyboardWillShowNotification = "keyboardWillShowNotification"
public let kNotificationKeyboardWillHideNotification = "keyboardWillHideNotification"

// MARK: - Form tags
public var kFormEmailAddress = "emailAddress"
public var kFormEmailPlaceholder = "youremail@gmail.com"
public var kFormPassword = "password"
public var kFormPasswordPlaceholder = "Enter your password"

// MARK: - Debug Credentials
public var kDebugEmail = ""
public var kDebugPassword = ""
