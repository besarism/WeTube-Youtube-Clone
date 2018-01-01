//
//  ViewController.swift
//  WeTube
//
//  Created by b3 on 12/22/17.
//  Copyright © 2017 b3. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //Vars:
    
    fileprivate let cellId = "cellId"
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        
        return mb
    }()
    
    let videos: [Video] = {
        //Channels:
        
        let appleChannel = Channel()
        appleChannel.name =  "Apple Inc"
        appleChannel.profileImage = "appleprofile"
        
        let b3Channel = Channel()
        b3Channel.name =  "B3 Apps"
        b3Channel.profileImage = "b3profile"
        
        
        //==============================================
        
        
        //Videos:
        
        let wwdc =  Video()
        wwdc.channel = appleChannel
        wwdc.thumbnailImage = "wwdcThumbnail"
        wwdc.title = "WWDC Event - Apple's World Wide Developers Conference 2016"
        wwdc.views = 7236274
        
        let mobombat =  Video()
        mobombat.channel = b3Channel
        mobombat.thumbnailImage = "mobombatThumbnail"
        mobombat.title = "Mo Bombat - B3 Apps"
        mobombat.views = 4326
        
        return [wwdc, mobombat]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView:
        fetchVideos()
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        //navBar
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.text = "Home"
        titleLabel.font = .systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        setupMenuBar()
        setupNavBarButtons()
        
    }

    
    //Methods:
    
    
    // TODO: fetchVideos
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //Error:
            if error != nil {
                print(error ?? "Error: No idea")
                return
            }
            
            //Everything is OK:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                //loop through JSON object
                for dictionary in json as! [[String: AnyObject]] {
                    print(dictionary["title"])
                }
            } catch let error {
                print (error)
            }
            
        }
        task.resume()
        

    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    private func setupNavBarButtons() {
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let navBarImage = UIImage(named: "nav_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchButton))
        let iconBarButtonItem = UIBarButtonItem(image: navBarImage, style: .plain, target: self, action: #selector(moreButton))
        navigationItem.rightBarButtonItems = [iconBarButtonItem, searchBarButtonItem]
    }
    
    @objc func searchButton() {
        print("Search")
    }
    
    @objc func moreButton() {
        print("More")
    }

    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: cellHeight + 75 + 12 + 8)
    }
    


}

