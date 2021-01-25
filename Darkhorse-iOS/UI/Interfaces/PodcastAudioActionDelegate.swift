//
//  PodcastAudioActionDelegate.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/25/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import Foundation

protocol PodcastAudioActionDelegate: class {
  var currentPodcast: String? { get set }
  var isPlaying: Bool { get set }
  var isRecording: Bool { get set }
  var progress: Double? { get set }

  func play()
  func pause()
  func next()
  func previous()
  func comment()
  func like()
  func record()
}

extension PodcastAudioActionDelegate {
  func play() { }
  func pause() { }
  func next() { }
  func previous() { }
  func comment() { }
  func like() { }
  func record() { }
}
