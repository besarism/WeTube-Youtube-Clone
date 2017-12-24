//
//  VideoCell.swift
//  WeTube
//
//  Created by b3 on 12/22/17.
//  Copyright © 2017 b3. All rights reserved.
//

import UIKit


class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            
            if let thmbnImage = video?.thumbnailImage {
                thumbnailImageView.image = UIImage(named: thmbnImage)
            }
            if let prflImage = video?.channel?.profileImage {
                profileImageView.image = UIImage(named: prflImage)
            }
            titleLabel.text = video?.title
            if let channelName = video?.channel?.name, let numberOfViews = video?.views {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                descriptionTextView.text = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 1 year ago"
            }
            
            

        }
    }
    
    
    var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .lightGray
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "b3profile"))
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        return  view
    }()
    
    
    override func setupViews() {
        //add subviews
        addSubview(thumbnailImageView)
        addSubview(separatorLine)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(descriptionTextView)
        
        
        //constraints for the subviews
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: profileImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorLine)
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, profileImageView, separatorLine)

        //top constraint for the titlelabel
        //v1:
//        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //v2:
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        
        
        //left constraint for the title label
        //v1:
//        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        //v2:
        titleLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true

//        //right constraint for the title label
//        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //v2:
        titleLabel.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 0).isActive = true
        
        //height constraint for the title label
        //v1:
        //        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //v2:
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        
        
        //top constraint for the description textView
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        
        //left constraint for the description textView
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //        //right constraint for the description textView
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        
        
        //height constraint for the description textView
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
       
        
        
    }
    
}


extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (key, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary["v\(key)"] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))

    }
}











