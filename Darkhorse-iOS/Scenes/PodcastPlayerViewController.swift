//
//  PodcastPlayerViewController.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/25/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit
import ConcentricProgressRingView
import EachNavigationBar
import Parchment

class PodcastPlayerViewController: UIViewController {

  @IBOutlet weak var beginningTitleLabel: UILabel!
  @IBOutlet weak var podcastImageView: UIImageView!
  @IBOutlet weak var endingTitleLabel: UILabel!
  @IBOutlet weak var podcastTitleLabel: UILabel!
  @IBOutlet weak var tapToBeginButton: UIButton!
  @IBOutlet weak var typePodcastTitleButton: UIButton!
  @IBOutlet weak var buttonOne: UIButton!
  @IBOutlet weak var buttonTwo: UIButton!
  @IBOutlet weak var buttonThree: UIButton!
  @IBOutlet weak var buttonFour: UIButton!
  @IBOutlet weak var buttonFive: UIButton!
  
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
    navitem.title = "DARKHORSE"
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
  
  static func setupViewController() -> PodcastPlayerViewController {
    let storyboard = UIStoryboard(name: kStoryboardMain,
                                  bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: PodcastPlayerViewController.identifier) as! PodcastPlayerViewController
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    podcastImageView.applyCornerRadius(0.25)
  }
  
  @IBAction func typePodcastTitleAction(_ sender: UIButton) {
  }
  
  @IBAction func tapToBeginRecordingAction(_ sender: UIButton) {
  }
  
  @IBAction func buttonOneAction(_ sender: UIButton) {
  }
  
  @IBAction func buttonTwoAction(_ sender: UIButton) {
  }
  
  @IBAction func buttonThreeAction(_ sender: UIButton) {
  }
  
  @IBAction func buttonFourAction(_ sender: UIButton) {
  }
  
  @IBAction func buttonFiveAction(_ sender: Any) {
  }

}
