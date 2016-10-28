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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    session = URLSession.shared
    task = URLSessionDownloadTask()
    loadData()
    }
  
  
  
    func loadData(){
      guard let shareSession = session, var downloadTask = task else { return }
      let url:URL! = URL(string: "https://api.spotify.com/v1/search?q=Nell&type=album&limit=50")
      downloadTask = shareSession.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
        if location != nil {
          let data:Data! = try? Data(contentsOf: location!)
          do{
            let dict = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
            //How do we get stuff from items? helppppp
            if let dictData = dict.value(forKey : "albums") as? [AnyObject] {
              for dict in dictData {
                if let album = Album(dict: dict) {
                  self.albums.append(album)
                }
              }
            
              DispatchQueue.main.async {
                self.tableView.reloadData()
              }
            }
          }catch{
            print("something went wrong, try again")
          }
        }
      })
      downloadTask.resume()
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
