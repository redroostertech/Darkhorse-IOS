//
//  WelcomeCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/18/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class WelcomeCell: UITableViewCell {

  @IBOutlet private var helloLabel: UILabel!

  public func configureCell(withName name: String) {
    helloLabel.text = name
  }

}
