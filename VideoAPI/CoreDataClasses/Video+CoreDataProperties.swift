//
//  Video+CoreDataProperties.swift
//  Vimeo-tvOS
//
//  Created by kartic on 20/11/17.
//  Copyright © 2017 KarticKhosla. All rights reserved.
//
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var name: String
    @NSManaged public var uri: String
    @NSManaged public var desc: String
    @NSManaged public var imageUrl: String

}
