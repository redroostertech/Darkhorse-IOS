//
//  StorageCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/23/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class StorageCell: UITableViewCell {

  @IBOutlet weak var totalStorageProgressView: UIView!
  @IBOutlet weak var otherAppsIndicator: UILabel!
  @IBOutlet weak var otherAppsPercentageLabel: UILabel!
  @IBOutlet weak var cacheIndicator: UILabel!
  @IBOutlet weak var cachePercentageLabel: UILabel!
  @IBOutlet weak var freeIndicator: UILabel!
  @IBOutlet weak var freePercentageLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    otherAppsIndicator.applyCornerRadius()
    cacheIndicator.applyCornerRadius()
    freeIndicator.applyCornerRadius()
  }
  
  func configure(otherAppsSpace: Double?,
                 freeSpace: Double?,
                 cacheSpace: Double?)
  {
    otherAppsPercentageLabel.text = "\(String(describing: otherAppsSpace)) GB"
    cachePercentageLabel.text = "\(String(describing: cacheSpace)) GB"
    freePercentageLabel.text = "\(String(describing: freeSpace)) GB"
  }
}
