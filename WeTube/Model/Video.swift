//
//  Video.swift
//  WeTube
//
//  Created by b3 on 12/24/17.
//  Copyright © 2017 b3. All rights reserved.
//

import UIKit

class Video: Decodable {
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: Int?
//    var uploadDate: Date?
    var duration: Int?

    var channel: Channel?
    
    private enum CodingKeys: String, CodingKey {
        case thumbnail_image_name
        case title
        case number_of_views
//        case uploadDate
        case duration
        case channel
    }


    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        thumbnail_image_name = try values.decode(String.self, forKey: .thumbnail_image_name)
        title = try values.decode(String.self, forKey: .title)
        number_of_views = try values.decode(Int.self, forKey: .number_of_views)
//        let uploadDate = try values.decode(Date.self, forKey: .uploadDate)
        duration = try values.decode(Int.self, forKey: .duration)
        channel = try values.decode(Channel.self, forKey: .channel)
    }

    
}

//public protocol JSONType: Decodable {
//    var jsonValue: Any { get }
//}
//
//extension NSNumber: JSONType {
//    public var jsonValue: Any {
//        return self
//    }
//}
//
//extension NSDate: JSONType {
//    public var jsonValue: Any {
//        return self
//    }
//}

