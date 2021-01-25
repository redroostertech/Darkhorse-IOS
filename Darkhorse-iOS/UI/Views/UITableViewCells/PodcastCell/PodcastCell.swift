//
//  PodcastCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/19/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {
  
  @IBOutlet weak var mainContainer: UIView!
  @IBOutlet weak var podcastImageView: UIImageView!
  @IBOutlet weak var podcastTitleLabel: UILabel!
  @IBOutlet weak var podcastByLabel: UILabel!
  @IBOutlet weak var podcastPlayButton: UIButton!

  weak var podcastAudioActionDelegate: PodcastAudioActionDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
    mainContainer.applyCornerRadius(0.25)
    mainContainer.backgroundColor = .darkGray
    podcastImageView.image = nil
    podcastImageView.applyCornerRadius(0.25)
    podcastTitleLabel.text = nil
    podcastByLabel.text = nil
    podcastPlayButton.applyCornerRadius()
  }
  
  func configure(podcastImage: UIImage?,
                 podcastTitle: String?,
                 podcastAuthor: String?,
                 podcastPlayActionDelegate: PodcastAudioActionDelegate) {
    podcastImageView.image = podcastImage
    podcastTitleLabel.text = podcastTitle
    podcastByLabel.text = "by \(podcastAuthor ?? "N/A")"
    podcastAudioActionDelegate = podcastPlayActionDelegate
  }

  @IBAction func podcastPlayButtonAction(_ sender: UIButton) {
    if
      let isPodcastPlaying = podcastAudioActionDelegate?.isPlaying,
      isPodcastPlaying
    {
      podcastAudioActionDelegate?.pause()
      podcastAudioActionDelegate?.isPlaying = false
      // update image in play button
    }
    else {
      podcastAudioActionDelegate?.play()
      podcastAudioActionDelegate?.isPlaying = true
      // update image in play button
    }
  }
}
