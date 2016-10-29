//
//  Album.swift
//  SpotifySearch
//
//  Created by Eric Chang on 10/28/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation

struct Album {
  internal let albumName: String
  internal let thumbnail: String
  internal let largeImage: String
  

  static func parseData (with data: Data) -> [Album]? {
    var albums: [Album] = []
    
    do {
      let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
      
      guard let jsonUnwrapped = jsonData as? [String:Any] else {
        print("JSON fail")
        return nil
      }
      guard let albumsUnwrapped = jsonUnwrapped["albums"] as? [String: Any] else {
        print("Albums fail")
        return nil
      }
      guard let itemsUnwrapped = albumsUnwrapped["items"] as? [[String: Any]] else {
        print("Items fail")
        return nil
      }
      
      for albumDictionary in itemsUnwrapped {
        guard let albumName = albumDictionary["name"] as? String else {
          print("Error: album name")
          return nil
        }
        guard let images = albumDictionary["images"] as? [[String:AnyObject]] else {
          print("Error: imagesDict")
          return nil
        }
        guard let thumbImage = images[2]["url"] as? String, let fullImage = images[0]["url"] as? String else {
          print("Error: hard coded image index")
          return nil
        }

        albums.append(self.init(albumName: albumName,
                                thumbnail: thumbImage,
                                largeImage: fullImage))
      }
      
    }
    catch {
      print("Error: \(error)")
    }
    return albums
  }
  
}
