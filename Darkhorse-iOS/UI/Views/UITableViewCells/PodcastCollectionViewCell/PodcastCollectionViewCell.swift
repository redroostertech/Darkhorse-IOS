//
//  PodcastCollectionViewCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/19/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class PodcastCollectionViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

  @IBOutlet weak var podcastCollectionView: UICollectionView!
  
  var podcasts = [String]()
  var collectionLayout: UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 260,
                             height: 175)
    layout.minimumInteritemSpacing = 5.0
    layout.scrollDirection = .horizontal
    return layout
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    podcastCollectionView.setCollectionViewLayout(collectionLayout, animated: true)
    podcastCollectionView.register(UINib(nibName: PodcastCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: PodcastCollectionCell.identifier)
    podcastCollectionView.delegate = self
    podcastCollectionView.dataSource = self
  }

  func configure(podcasts: [String]) {
    self.podcasts.append(contentsOf: podcasts)
    podcastCollectionView.reloadData()
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return podcasts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PodcastCollectionCell.identifier, for: indexPath) as? PodcastCollectionCell
    let item = podcasts[indexPath.row]
    cell?.configure(podcastImage: nil,
                    podcastTitle: nil,
                    podcastAuthor: nil,
                    podcastOwnerImage: nil,
                    podcastPlayActionDelegate: nil)
    return cell ?? UICollectionViewCell()
  }
}
