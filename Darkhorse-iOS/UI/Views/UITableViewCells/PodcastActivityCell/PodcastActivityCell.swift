//
//  PodcastActivityCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/23/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class PodcastActivityCell: UITableViewCell {

  @IBOutlet weak var mainContainer: UIView!
  @IBOutlet weak var podcastImageView: UIImageView!
  @IBOutlet weak var podcastTitleLabel: UILabel!
  @IBOutlet weak var podcastByLabel: UILabel!
  @IBOutlet weak var podcastPlayButton: UIButton!
  @IBOutlet weak var podcastCategoryLabel: UILabel!
  @IBOutlet weak var podcastProgressView: UIProgressView!
  
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
                 podcastCategory: String?,
                 podcastPlayActionDelegate: PodcastAudioActionDelegate) {
    podcastImageView.image = podcastImage
    podcastTitleLabel.text = podcastTitle
    podcastCategoryLabel.text = podcastCategory
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
