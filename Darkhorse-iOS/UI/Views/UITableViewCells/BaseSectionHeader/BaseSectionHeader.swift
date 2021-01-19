//
//  BaseSectionHeader.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/19/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

protocol SectionHeaderActionDelegate: class {
  func primaryAction()
}

class BaseSectionHeader: UITableViewHeaderFooterView {

  @IBOutlet weak var sectionTitleLabel: UILabel!
  @IBOutlet weak var sectionPrimaryActionButton: UIButton!
  
  weak var sectionHeaderDelegate: SectionHeaderActionDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    sectionTitleLabel.text = nil
    sectionHeaderDelegate = nil
  }

  func configure(title: String,
                 sectionDelegate: SectionHeaderActionDelegate?) {
    sectionTitleLabel.text = title
    sectionHeaderDelegate = sectionDelegate
  }

  @IBAction func sectionPrimaryButtonAction(_ sender: UIButton) {
    sectionHeaderDelegate?.primaryAction()
  }
}
