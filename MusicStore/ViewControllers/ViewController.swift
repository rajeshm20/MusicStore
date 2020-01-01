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
    
    func getImage(imgName: String) -> UIImage {
        
//        let bundle = Bundle.main
        
        let image = UIImage(named: imgName)
        
        if image != nil {
            
            return image!
            
        } else {
            
            let image = UIImage(named: "placeholder")
            return image!
        }
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell = albumTableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumCell
        let album = albums[indexPath.row]
        let artistID = album.ArtistId
        let artistName = artists[artistID].Name
        albumCell.albumTitleLabel.text = album.Title
        albumCell.artistNameLabel.text = "By:  \(artistName)"
        albumCell.albumImageView.image = self.getImage(imgName: "\(artistID)")
        
        return albumCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = albums[indexPath.row]
        let artist = artists[selected.ArtistId].Name
        print("user tapped album \(selected.Title) by \(artist)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
}
