//
//  SettingsCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/23/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

protocol SettingsControlDelegate: class {
  var selectedSetting: String? { get set }
  func turnOff()
  func turnOn()
}

class SettingsCell: UITableViewCell {
  
  @IBOutlet weak var settingsTitleLabel: UILabel!
  @IBOutlet weak var settingsDescriptionLabel: UILabel!
  @IBOutlet weak var settingsSwitch: UISwitch!
  @IBOutlet weak var turnOnAndTurnOffButton: UIButton!
  
  weak var settingsControlDelegate: SettingsControlDelegate?
  
  func configure(title: String?,
                 description: String?,
                 settingsControlDelegate: SettingsControlDelegate?)
  {
    settingsTitleLabel.text = title
    settingsDescriptionLabel.text = description
    self.settingsControlDelegate = settingsControlDelegate
  }

  
  @IBAction func turnOnAndTurnOffAction(_ sender: UIButton) {
    // Check if setting is on, flip settings switch
    settingsControlDelegate?.turnOn()
  }
}
