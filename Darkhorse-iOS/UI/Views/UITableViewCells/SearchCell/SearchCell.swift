//
//  SearchCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/18/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
  @IBOutlet private weak var searchField: UITextField!

  override func awakeFromNib() {
    super.awakeFromNib()
    searchField.applyCornerRadius()
    searchField.left(image: UIImage(named: "search"),
                     color: .green)
  }

  func configure(withDelegate delegate: UITextFieldDelegate) {
    searchField.delegate = delegate
  }
}
