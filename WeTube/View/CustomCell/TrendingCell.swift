//
//  TrendingCell.swift
//  WeTube
//
//  Created by b3 on 1/27/18.
//  Copyright © 2018 b3. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        
        ApiService.sharedInstance.fetchVideos(stringURL: "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json") { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
