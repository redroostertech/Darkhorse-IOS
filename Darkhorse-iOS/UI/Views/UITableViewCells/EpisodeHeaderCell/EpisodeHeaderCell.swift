//
//  EpisodeHeaderCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/23/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class EpisodeHeaderCell: UITableViewCell {
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var podcastImageView: UIImageView!
  @IBOutlet weak var podcastTitleLabel: UILabel!
  @IBOutlet weak var podcastDescriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    podcastImageView.applyCornerRadius(0.25)
    // Add gradient to background image
  }
  
  func configure(podcastImage: UIImage?,
                 podcastTitle: String?,
                 podcastDescription: String?)
  {
    backgroundImageView.image = podcastImage
    podcastImageView.image = podcastImage
    podcastTitleLabel.text = podcastTitle
    podcastDescriptionLabel.text = podcastDescription
  }
}
