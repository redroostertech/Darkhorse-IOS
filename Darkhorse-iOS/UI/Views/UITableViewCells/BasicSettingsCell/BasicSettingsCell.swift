//
//  BasicSettingsCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/23/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class BasicSettingsCell: UITableViewCell {

  @IBOutlet weak var settingsTitleLabel: UILabel!
  @IBOutlet weak var settingsDescriptionLabel: UILabel!
    
  func configure(title: String?,
                 description: String?)
  {
    settingsTitleLabel.text = title
    settingsDescriptionLabel.text = description
    self.settingsControlDelegate = settingsControlDelegate
  }
}
