//
//  HeaderCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/22/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  func configure(title: String?) {
    titleLabel.text = title
  }
}
