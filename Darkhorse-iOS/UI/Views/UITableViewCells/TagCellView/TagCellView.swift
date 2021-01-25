//
//  TagCellView.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/25/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit
import ASHorizontalScrollView

class TagCellView: UITableViewCell {
  
  @IBOutlet weak var horizontalScrollView: ASHorizontalScrollView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    horizontalScrollView.marginSettings_320 = MarginSettings(leftMargin: 10,
                                                             miniMarginBetweenItems: 5,
                                                             miniAppearWidthOfLastItem: 20)
    //for iPhone 4s and lower versions in landscape
    horizontalScrollView.marginSettings_480 = MarginSettings(leftMargin: 10,
                                                             miniMarginBetweenItems: 5,
                                                             miniAppearWidthOfLastItem: 20)
    // for iPhone 6 plus and 6s plus in portrait
    horizontalScrollView.marginSettings_414 = MarginSettings(leftMargin: 10,
                                                             miniMarginBetweenItems: 5,
                                                             miniAppearWidthOfLastItem: 20)
    // for iPhone 6 plus and 6s plus in landscape
    horizontalScrollView.marginSettings_736 = MarginSettings(leftMargin: 10,
                                                             miniMarginBetweenItems: 10,
                                                             miniAppearWidthOfLastItem: 30)
    //for all other screen sizes that doesn't set here, it would use defaultMarginSettings instead
    horizontalScrollView.defaultMarginSettings = MarginSettings(leftMargin: 10,
                                                                miniMarginBetweenItems: 10,
                                                                miniAppearWidthOfLastItem: 20)
    horizontalScrollView.uniformItemSize = CGSize(width: 80, height: 50)
    //this must be called after changing any size or margin property of this class to get acurrate margin
    horizontalScrollView.setItemsMarginOnce()
  }
  
  func configure(withTags tags: [String]) {
    for tag in tags {
      let button = UIButton(frame: CGRect.zero)
      button.backgroundColor = UIColor.purple
      button.setTitle(tag,
                      for: .normal)
      button.applyCornerRadius()
      self.horizontalScrollView.addItem(button)
    }
  }
}
