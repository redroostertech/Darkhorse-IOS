//
//  RecordDrawerViewController.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/25/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit
import ConcentricProgressRingView

class RecordDrawerViewController: UIViewController {
  @IBOutlet weak var miniBarView: UIView!
  @IBOutlet weak var beginningTitleLabel: UILabel!
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var endingTitleLabel: UILabel!
  @IBOutlet weak var podcastTitleLabel: UILabel!
  @IBOutlet weak var tapToBeginButton: UIButton!
  @IBOutlet weak var typePodcastTitleButton: UIButton!
  @IBOutlet weak var buttonOne: UIButton!
  @IBOutlet weak var buttonTwo: UIButton!
  @IBOutlet weak var buttonThree: UIButton!
  @IBOutlet weak var buttonFour: UIButton!
  
  static func setupViewController() -> RecordDrawerViewController {
    let storyboard = UIStoryboard(name: kStoryboardMain,
                                  bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: RecordDrawerViewController.identifier) as! RecordDrawerViewController
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    recordButton.applyCornerRadius()
    miniBarView.applyCornerRadius()
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
}
