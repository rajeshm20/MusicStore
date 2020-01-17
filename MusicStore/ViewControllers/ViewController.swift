//
//  ViewController.swift
//  MusicStore
//
//  Created by RNSS on 28/12/19.
//  Copyright © 2019 RNSS. All rights reserved.
//

import UIKit
import GRDB

class ViewController: UIViewController {

    @IBOutlet weak var albumTableView: UITableView!
    var albums = [Album]()
    var albumCount: Int?=nil
    
    var artists = [Artist]()
    var artistCount: Int?=nil
 
     override func viewWillAppear(_ animated: Bool) {
        self.getAlbumData()
        self.getArtisData()
    }
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.albumTableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: "albumCell")

        
    }


    func getAlbumData(){
        let dbPath = Util().getDbPathString()
        do{
            //setting up database queue
            let dbQueue = try DatabaseQueue(path:dbPath)
            //Fetch records and count from database
             try dbQueue.read { db in
                 albums = try Album.fetchAll(db)
                 albumCount = try Album.fetchCount(db)
                
                print("all albums: ", albums)
                print("albums count", albumCount!)
            }
            
        } catch {
            
            print("db error: \(error)")
        }

    }
    
    func getArtisData(){
        let dbPath = Util().getDbPathString()
        do{
            //setting up database queue
            let dbQueue = try DatabaseQueue(path:dbPath)
            //Fetch records and count from database
            try dbQueue.read { db in
                artists = try Artist.fetchAll(db)
                artistCount = try Artist.fetchCount(db)
                
                print("all albums: ", artists)
                print("albums count", artistCount as Any)
            }
            
        } catch {
            
            print("db error: \(error)")
        }
        
    }
    
     func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if segue!.identifier == "toTrack" {
            let viewController:TrackViewController = segue!.destination as! TrackViewController
            let indexPath = self.albumTableView.indexPathForSelectedRow
//            viewController.albumID = self.albums[(sender?.indexPath.row)!].AlbumId
            viewController.albumID = self.albums[(indexPath?.row)!].AlbumId
            viewController.artistID = self.artists[(indexPath?.row)!].ArtistId

        }

    }
    
    
    func openTracksOfSelectedAlbumByID(albumID: Int64, artistID: Int64){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
        controller.albumID = albumID
        controller.artistID = artistID

        self.present(controller, animated: true, completion: nil)

    }
    
    

}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell = albumTableView.dequeueReusableCell(withIdentifier: "albumCell") as! AlbumCell
        let album = albums[indexPath.row]
        let artistID = album.ArtistId
        let artistName = artists[artistID].Name
        albumCell.albumTitleLabel.text = album.Title
        albumCell.artistNameLabel.text = "By:  \(artistName)"
        albumCell.albumImageView.image = Util().getImage(imgName: "\(artistID)")
        
        return albumCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selected = albums[indexPath.row]
        let artist = artists[selected.ArtistId].Name
        let artistID = albums[indexPath.row].ArtistId
        print("user tapped album \(selected.AlbumId) \(selected.Title) by \(artist), artistID:\(artistID)")
        openTracksOfSelectedAlbumByID(albumID: selected.AlbumId, artistID: Int64(artistID))
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
}
