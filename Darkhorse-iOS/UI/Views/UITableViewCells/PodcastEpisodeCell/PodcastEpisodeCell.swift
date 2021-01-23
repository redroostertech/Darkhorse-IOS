//
//  PodcastEpisodeCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/23/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class PodcastEpisodeCell: UITableViewCell {
  @IBOutlet weak var mainContainer: UIView!
  @IBOutlet weak var podcastImageView: UIImageView!
  @IBOutlet weak var podcastTitleLabel: UILabel!
  @IBOutlet weak var podcastByLabel: UILabel!
  @IBOutlet weak var podcastMoreButton: UIButton!
  
  weak var podcastAudioActionDelegate: PodcastAudioActionDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    mainContainer.applyCornerRadius(0.25)
    mainContainer.backgroundColor = .darkGray
    podcastImageView.image = nil
    podcastImageView.applyCornerRadius(0.25)
    podcastTitleLabel.text = nil
    podcastByLabel.text = nil
  }
  
  func configure(podcastImage: UIImage?,
                 podcastTitle: String?,
                 podcastAuthor: String?,
                 podcastPlayActionDelegate: PodcastAudioActionDelegate)
  {
    podcastImageView.image = podcastImage
    podcastTitleLabel.text = podcastTitle
    podcastByLabel.text = "by \(podcastAuthor ?? "N/A")"
    podcastAudioActionDelegate = podcastPlayActionDelegate
  }
  
  @IBAction func podcastMoreButtonAction(_ sender: UIButton) {
    
  }
}
