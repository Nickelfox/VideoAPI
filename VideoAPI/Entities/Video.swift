//
//  Video.swift
//  Model
//
//  Created by kartic on 11/12/17.
//  Copyright © 2017 KarticKhosla. All rights reserved.
//

import Foundation
import APIClient
import JSONParsing
import CoreData

fileprivate let context = CoreDataStack.shared.persistentContainer.viewContext

extension Video: JSONParseable {
    public static func parse(_ json: JSON) throws -> Video {
        
        func update(_ video: Video, json: JSON) throws {
            do {
                video.name = try json["name"]^
                video.desc = try json["description"]^
                video.uri = try json["uri"]^
                var picture = Picture()
                picture = try json["pictures"]^
                if let link = picture.sizes.last?.link {
                    video.imageUrl = link
                } else {
                    video.imageUrl = ""
                }
                try context.save()
            } catch {
                throw error
            }
        }
        
        do {
            let uri: String = try json["uri"]^
            let req = NSFetchRequest<Video>(entityName: "Video")
            let predicate = NSPredicate(format: "uri = '\(uri)'")
            req.predicate = predicate
            if let video = try context.fetch(req).first {
                try update(video, json: json)
                return video
            } else {
                let video = Video(context: context)
                try update(video, json: json)
                return video
            }
        } catch {
            throw error
        }
    }
}

extension Video {
    
    public static func fetchVideos(completion: @escaping ([Video]) -> Void) {
        
        do {
            let video = try context.fetch(Video.fetchRequest()) as! [Video]
            if !video.isEmpty {
                completion(video)
            }
        } catch let error {
            print(error)
        }
        
        VimeoClient.shared.request(router: VimeoRouter.getVideo) { (result: APIResult<ListResponse<Video>>) in
            switch result {
            case .success(let response):
                completion(response.list)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public static func cachedVideos() -> [Video] {
        
        do {
            let videos = try context.fetch(Video.fetchRequest()) as! [Video]
            return videos
        } catch {
            return []
        }        
    }

    
    static func clearCoreData() {
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Video")
        let deleteReq = NSBatchDeleteRequest(fetchRequest: req)
        do {
            let _ = try context.execute(deleteReq)
            try context.save()
        } catch let error{
            print(error)
        }
    }
}

final public class Picture:  JSONParseable {
    var sizes: [Size] = []
    
    init() {
    }
    
    init(sizes: [Size]) {
        self.sizes = sizes
    }
    
    public static func parse(_ json: JSON) throws -> Picture {
        return try Picture(sizes: json["sizes"]^^)
    }
}

final public class Size: JSONParseable {
    var link: String
    
    init(link: String) {
        self.link = link
    }
    
    public static func parse(_ json: JSON) throws -> Size {
        return try Size(link: json["link"]^)
    }
}

