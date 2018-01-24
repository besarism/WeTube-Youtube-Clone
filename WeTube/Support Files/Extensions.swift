//
//  Extensions.swift
//  WeTube
//
//  Created by b3 on 1/11/18.
//  Copyright © 2018 b3. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    //Methods:
    func setupImage(_ urlString: String?) {
        if let urlToImage = urlString {
            imageUrlString = urlString
            let url = URL(string: urlToImage)
            self.image = nil
            
            image = nil
            if let imageFromCache = imageCache.object(forKey: urlString! as NSString) as? UIImage{
                self.image = imageFromCache
                return
            }

            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error ?? "error")
                    return
                }
                
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache!, forKey: urlString! as NSString)
                }
                
                
                
            }).resume()
        }
    }

}
