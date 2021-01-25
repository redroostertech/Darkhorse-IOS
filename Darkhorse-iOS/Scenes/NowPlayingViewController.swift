//
//  NowPlayingViewController.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/25/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit
import EachNavigationBar
import Parchment
import DrawerView

class NowPlayingViewController: UIViewController, DrawerViewDelegate {
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  internal var drawerView: DrawerView?
  
  private var navigationBar: EachNavigationBar?
  private var navBarHeight: CGFloat = kNavBarHeight
  private var navBar: EachNavigationBar {
    let navbar = EachNavigationBar(viewController: self)
    navbar.frame = CGRect(x: .zero,
                          y: kTopOfScreenPlusStatusBar,
                          width: kWidthOfScreen,
                          height: navBarHeight)
    navbar.barTintColor = .white
    navbar.prefersLargeTitles = true
    
    navbar.isShadowHidden = true
    navbar.items = [ navItem ]
    navbar.tintColor = .black
    navbar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    navbar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    
    return navbar
  }
  
  private var navItem: UINavigationItem {
    let navitem = UINavigationItem()
    navitem.title = "Now Playing"
    //    let menuButton = UIBarButtonItem(image: UIImage(named: kImageMenu)!.maskWithColor(color: .black),
    //                                     style: .plain,
    //                                     target: self,
    //                                     action: #selector(HomeViewController.showMenu))
    //    menuButton.tintColor = .white
    
    //    let userProfileButton = UIBarButtonItem(image: UIImage(named: kImageHistory)!.maskWithColor(color: .black),
    //                                            style: .plain,
    //                                            target: self,
    //                                            action: #selector(HomeViewController.showFilterOptions))
    
    //    navitem.leftBarButtonItems = [
    //      menuButton
    //    ]
    
    //    navitem.rightBarButtonItems = [
    //      userProfileButton
    //    ]
    
    navitem.largeTitleDisplayMode = .always
    return navitem
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // Load Authentication Embed View for Drawer
    let signinVC = NowPlayingDrawerViewController.setupViewController() as! NowPlayingDrawerViewController
    
    self.addChild(signinVC)
    
    // Load Drawer View
    let drawerview = DrawerView(withView: signinVC.view)
    drawerview.attachTo(view: self.view)
    drawerview.snapPositions = [
      .open,
      .partiallyOpen,
    ]
    drawerview.delegate = self
    drawerview.backgroundColor = .white
    drawerview.backgroundEffect = nil // UIBlurEffect(style: .regular)
    drawerview.insetAdjustmentBehavior = .automatic
    drawerview.position = .partiallyOpen
    
    drawerView = drawerview
  }
  
  func openDrawer(_ sender: UIViewController) {
    drawerView?.setPosition(
      .open,
      animated: true
    )
  }
  
  func drawer(_ drawerView: DrawerView, didTransitionTo position: DrawerPosition) {
    if position == .closed || position == .partiallyOpen {
      self.view.endEditing(true)
    }
  }
}
