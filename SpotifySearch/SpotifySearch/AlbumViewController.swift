//
//  AlbumViewController.swift
//  SpotifySearch
//
//  Created by Eric Chang on 10/28/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

  @IBOutlet weak var albumLargeImageView: UIImageView!
  
  var thisAlbum: Album?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      loadImage(url: URL(string: thisAlbum!.largeImage)!)
  }


  func loadImage(url: URL) {
    let shareSession = URLSession.shared
    let downloadTask = shareSession.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
      if location != nil {
        DispatchQueue.main.async {
          let data:Data! = try? Data(contentsOf: location!)
          let image = UIImage(data: data)
          self.albumLargeImageView.image = image
        }
      }
    })
    downloadTask.resume()
  }



}
