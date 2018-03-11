//
//  FeedCell.swift
//  WeTube
//
//  Created by b3 on 1/27/18.
//  Copyright © 2018 b3. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        
        return cv
    }()
    
    var videos: [Video]?
    let cellId = "cellId"

    
    override func setupViews() {
        super.setupViews()
        
        //collectionView
        fetchVideos()
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }
//    http://www.ibelian.com/Services/API/json/kOpfek35WKWdfwkg/home.json"
    // MARK: fetchVideos
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos(stringURL: "http://www.ibelian.com/Services/API/json/kOpfek35WKWdfwkg/home.json") { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: cellHeight + 75 + 12 + 8)
    }

    
    
    
}
