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
    fileprivate let trendingCellId = "trendingCellId"
    fileprivate let subscriptionsCellId = "subscriptionsCellId"
    fileprivate let accountCellId = "accountCellId"

    var categoryTitles = ["Home", "Trending", "Subscriptions", "Account"]
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        
        return mb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView:
        setupCollectionView()
        
        
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
    
        
    private func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.isPagingEnabled = true
        
        //register cells
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionsCellId)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: accountCellId)

    

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
    
    func scrolltoMenuIndex(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        updateNavTitle(at: index)
    }
    
    private func updateNavTitle(at index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(categoryTitles[index])"
        }
    }
    
    
    
    
    //MARK: CollectionView
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 4
        print("scrollViewDidScroll: \(scrollView.contentOffset.x / 4) ")
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging: \(targetContentOffset.pointee.x) ")
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        updateNavTitle(at: Int(index))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitles.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIds = [cellId, trendingCellId, subscriptionsCellId, accountCellId]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIds[indexPath.item], for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    
    

    func draw() {
        print("drawing")
    }
}

