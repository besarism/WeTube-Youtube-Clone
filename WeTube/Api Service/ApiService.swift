//
//  File.swift
//  WeTube
//
//  Created by b3 on 1/23/18.
//  Copyright © 2018 b3. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchVideos(stringURL: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: stringURL)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //Error:
            if error != nil {
                print(error ?? "Error: No idea")
                return
            }
            var videos = [Video]()
            
            //15 lines of code replaced with 2 lines of code
            do {
                try videos = JSONDecoder().decode([Video].self, from: data!)
            } catch let error { print(error) }

            DispatchQueue.main.async {
                completion(videos)
            }
            
        }
        task.resume()
    }
}



/* Old version:
 
 let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
 var videos = [Video]()
 //loop through JSON object
 for dictionary in json as! [[String: AnyObject]] {
 let video = Video()
 video.title = dictionary["title"] as? String
 video.thumbnailImage = dictionary["thumbnail_image_name"] as? String
 video.views = dictionary["number_of_views"] as? NSNumber
 
 let channelDictionary = dictionary["channel"] as! [String: AnyObject]
 let channel = Channel()
 channel.name = channelDictionary["name"] as? String
 channel.profileImage = channelDictionary["profile_image_name"] as? String
 video.channel = channel
 
 videos.append(video)
 
 vs new version:
 
 do {
 try videos = JSONDecoder().decode([Video].self, from: data!)
 } catch let error { print(error) }


 
 */



