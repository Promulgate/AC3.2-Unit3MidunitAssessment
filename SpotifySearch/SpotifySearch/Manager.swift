//
//  Manager.swift
//  SpotifySearch
//
//  Created by Eric Chang on 10/28/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import Foundation

class APIManager {
  
  static let manager = APIManager()
  private init () {}
  
  func getData (endPoint: String, callback: @escaping (Data?) -> Void) {
    if let validURL = URL(string: endPoint) {
      
      let session = URLSession(configuration: .default)
      
      session.dataTask(with: validURL) { (data: Data?, response: URLResponse?, error: Error?) in
        if error != nil {
          print("Session Error: \(error)")
        }
        
        if let validData = data {
          callback(validData)
        }
      }.resume()
    }
  }
}
