//
//  QuickActionView.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/22/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class QuickActionView: UIViewController {
  
  @IBOutlet weak var podcastImageView: UIImageView!
  @IBOutlet weak var podcastTitleView: UILabel!
  @IBOutlet weak var podcastOwnerLabel: UILabel!
  @IBOutlet weak var primaryButton: UIButton!

  weak var podcastAudioActionDelegate: PodcastAudioActionDelegate?

  @IBAction func primaryButtonAction(_ sender: Any) {
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
