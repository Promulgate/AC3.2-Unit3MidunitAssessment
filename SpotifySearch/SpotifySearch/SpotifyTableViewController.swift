//
//  SpotifyTableViewController.swift
//  SpotifySearch
//
//  Created by Eric Chang on 10/28/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class SpotifyTableViewController: UITableViewController {
  
  var session: URLSession?
  var task: URLSessionDownloadTask?
  var albums = [Album]()
  var endpoint = "https://api.spotify.com/v1/search?q=Nell&type=album&limit=50"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    session = URLSession.shared
    task = URLSessionDownloadTask()
    
    APIManager.manager.getData(endPoint: endpoint) { (data: Data?) in
      if let d = data {
        self.albums = Album.parseData(with: d)!
        print(self.albums.count)
        
      }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  
  
  // MARK: - Table view data source
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albums.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! SearchTableViewCell
    
    let album = albums[indexPath.row]
    cell.albumImageView.downloadImage(urlString: album.thumbnail)
    cell.albumNameLabel.text = album.albumName
    
    return cell
  }
  
  
  
  // MARK: - Navigation
  // MARK: - Navigation
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let tappedAlbum: UITableViewCell = sender as? UITableViewCell {
      if segue.identifier == "albumPickSegue" {
        let albumDetail: AlbumViewController = segue.destination as! AlbumViewController
        let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedAlbum)!
        
        albumDetail.thisAlbum = albums[cellIndexPath.row]
      }
    }
    
  }
  
  
}
