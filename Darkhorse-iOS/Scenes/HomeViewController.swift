//
//  HomeViewController.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/22/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit
import EachNavigationBar
import Parchment

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var mainTableView: UITableView!
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
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.register(WelcomeCell.nib,
                           forCellReuseIdentifier: WelcomeCell.identifier)
    mainTableView.register(SearchCell.nib,
                           forCellReuseIdentifier: SearchCell.identifier)
    mainTableView.register(PodcastCollectionViewCell.nib,
                           forCellReuseIdentifier: PodcastCollectionViewCell.identifier)
    mainTableView.register(SearchCell.nib,
                           forCellReuseIdentifier: SearchCell.identifier)
//    mainTableView.register(BaseSectionHeader.loadNib(), forHeaderFooterViewReuseIdentifier: BaseSectionHeader.identifier)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int
  {
    switch section {
      case 0:
        return 2

      default:
          return 5
    }
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    switch indexPath.section {
      case 0:
        return UITableViewCell()
      
      default:
        return UITableViewCell()
    }
  }
}
