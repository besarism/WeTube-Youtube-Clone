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
    
    var videos: [Video]?
    
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
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
        
    }
    
    private func setupMenuBar() {
        
        let redBackgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1.0)
            
            return view
        }()
        
        view.addSubview(redBackgroundView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redBackgroundView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redBackgroundView)
        
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        let guide = view.safeAreaLayoutGuide
        navigationController?.hidesBarsOnSwipe = true
        menuBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        
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
    lazy var settingsLauncher: SettingsLauncher = {
        let settingsLauncher = SettingsLauncher()
        settingsLauncher.homeController = self
        
        return settingsLauncher
    }()
    @objc func moreButton() {
        settingsLauncher.showSettings()
    }
    
    func showController(For setting: Setting) {
        let dummyViewController = UIViewController()
        dummyViewController.view.backgroundColor = .white
        dummyViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummyViewController, animated: true)
    }

    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: cellHeight + 75 + 12 + 8)
    }
    

    func draw() {
        print("drawing")
    }
}

