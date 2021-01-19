//
//  PodcastCollectionViewCell.swift
//  Darkhorse-iOS
//
//  Created by Michael Westbrooks on 1/19/21.
//  Copyright © 2021 Nuracode. All rights reserved.
//

import UIKit

class PodcastCollectionViewCell: UITableViewCell {

  @IBOutlet weak var podcastCollectionView: UICollectionView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
