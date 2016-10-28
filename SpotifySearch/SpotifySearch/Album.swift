//
//  Album.swift
//  SpotifySearch
//
//  Created by Eric Chang on 10/28/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation

class Album {
  let albumName: String
  let thumbnail: String
  let largeImage: String
  
  init(album: String, imageURL: [[String:Any]]) {
    albumName = album
    thumbnail = imageURL[3]["url"] as! String
    largeImage = imageURL[0]["url"] as! String
  }
  
  convenience init?(dict: AnyObject) {
      if let album = dict["name"] as? String, let imageURL = dict["images"] as? [[String:Any]] {
      self.init(album: album, imageURL: imageURL)
    }
    
    else { return nil }
  }
  
}
