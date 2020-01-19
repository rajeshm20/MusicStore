//
//  TrackViewController.swift
//  MusicStore
//
//  Created by RNSS on 10/01/20.
//  Copyright © 2020 RNSS. All rights reserved.
//

import UIKit
import GRDB	

class TrackViewController: UIViewController {

    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var trackTableView: UITableView!
    var artistID:Int64?=0
    var albumID:Int64?=nil
    var tracks = [Track]()
    var trackCount:Int?=nil
    var genres = [Genre]()
    var mediaTypes = [MediaType]()
    
    override func viewWillAppear(_ animated: Bool) {
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGenreand()
        fetchMediaType()
             
             if albumID != nil {
                print("albumid: \(String(describing: albumID))")
                print("artistID: \(String(describing: artistID))")

                fetchTrackByAlbumID(id: albumID!)

             } else {
                 
                 print("no data received")
             }
             
        self.trackTableView.register(UINib(nibName: "TrackTableViewCell", bundle: nil), forCellReuseIdentifier: "trackCell")

        albumImageView.image = Util().getImage(imgName: "\(artistID!)")
        // Do any additional setup after loading the view.
        print("tracksfetched: \(tracks)")
    }
    
    func fetchTrackByAlbumID(id: Int64){
        
        let dbPath = Util().getDbPathString()
        do {
        let dbQueue = try DatabaseQueue(path: dbPath)
            
            try dbQueue.read { db in
                
                tracks = try Track.fetchAll(db, sql: "SELECT * FROM Track WHERE AlbumId = ?", arguments: [id])
                trackCount = tracks.count
                
            }
        } catch {
            
            print("\(error.localizedDescription)")
        }
        
    }
    
    func fetchGenreand(){
        
        let dbPath = Util().getDbPathString()
        do {
        let dbQueue = try DatabaseQueue(path: dbPath)
            
            try dbQueue.read { db in
                
                genres = try Genre.fetchAll(db)
                
            }
        } catch {
            
            print("\(error.localizedDescription)")
        }
        
    }
    
    
    func fetchMediaType(){
          
          let dbPath = Util().getDbPathString()
          do {
          let dbQueue = try DatabaseQueue(path: dbPath)
              
              try dbQueue.read { db in
                  
                  mediaTypes = try MediaType.fetchAll(db)
                  
              }
          } catch {
              
              print("\(error.localizedDescription)")
          }
          
      }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension TrackViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell") as! TrackTableViewCell
        let track = tracks[indexPath.row]
        cell.trackNameLabel.text = "Track Name: " + track.Name
        let price = Double(track.UnitPrice)
        cell.unitPriceLabel.text = "Unit Price: $\(price)"
        cell.mediaType.text = "Medica Type: " + mediaTypes[track.MediaTypeId].Name
        cell.genreLabel.text = "Genre: " + genres[track.GenreId].Name
        var composer: String?=nil
        composer = track.Composer
        if composer == nil {
            
            cell.composerLabel.text = "Composer: "
            
        } else {
            
            cell.composerLabel.text = "Composer: " + composer!
            
        }
        let toMB = (track.Bytes / 1024) / 1024
        
        cell.bytesLabel.text = "Size: " + String(toMB) + " MB"
        
        let inMinutes = track.Milliseconds / 60000
        
        cell.durationLabel.text = "Duration: " + String(inMinutes) + " minutes"
        
        
        
        

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 271
    }
    
}
