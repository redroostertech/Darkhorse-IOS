//
//  PodcastCollectionCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/19/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class PodcastCollectionCell: UICollectionViewCell {

  @IBOutlet weak var mainContentView: UIView!
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ownerLabel: UILabel!
  @IBOutlet weak var ownerImageView: UIImageView!
  @IBOutlet weak var podcastImageView: UIImageView!
  
  weak var podcastAudioActionDelegate: PodcastAudioActionDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
    mainContentView.backgroundColor = .clear
    playButton.applyCornerRadius()
    playButton.backgroundColor = .white
    podcastImageView.applyCornerRadius(0.25)
  }

  func configure(podcastImage: UIImage?,
                 podcastTitle: String?,
                 podcastAuthor: String?,
                 podcastOwnerImage: UIImage?,
                 podcastPlayActionDelegate: PodcastAudioActionDelegate?) {
    podcastImageView.image = podcastImage
    ownerImageView.image = podcastOwnerImage
    titleLabel.text = podcastTitle
    ownerLabel.text = "by \(podcastAuthor ?? "N/A")"
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

