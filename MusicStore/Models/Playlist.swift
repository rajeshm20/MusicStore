//
//  Playlist.swift
//  MusicStore
//
//  Created by RNSS on 01/01/20.
//  Copyright © 2020 RNSS. All rights reserved.
//

import GRDB

// A plain Player struct
struct Playlist {
    // Prefer Int64 for auto-incremented database ids
    var PlaylistId: Int
    var Name: String
}

// Hashable conformance supports tableView diffing
extension Playlist: Hashable { }

// MARK: - Persistence

// Turn Player into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Playlist: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let PlaylistId = Column(CodingKeys.PlaylistId)
        static let Name = Column(CodingKeys.Name)
    }
    
    // Update a player id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        PlaylistId = Int(rowID)
    }
}

// MARK: - Database access

// Define some useful player requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Playlist {
    static func orderedByID() -> QueryInterfaceRequest<Playlist> {
        return Playlist.order(Columns.PlaylistId)
    }
    
    static func orderedByName() -> QueryInterfaceRequest<Playlist> {
        return Playlist.order(Columns.Name.desc, Columns.Name)
    }
}

// MARK: - Player Randomization

//extension Player {
//    private static let names = [
//        "Arthur", "Anita", "Barbara", "Bernard", "Craig", "Chiara", "David",
//        "Dean", "Éric", "Elena", "Fatima", "Frederik", "Gilbert", "Georgette",
//        "Henriette", "Hassan", "Ignacio", "Irene", "Julie", "Jack", "Karl",
//        "Kristel", "Louis", "Liz", "Masashi", "Mary", "Noam", "Nicole",
//        "Ophelie", "Oleg", "Pascal", "Patricia", "Quentin", "Quinn", "Raoul",
//        "Rachel", "Stephan", "Susie", "Tristan", "Tatiana", "Ursule", "Urbain",
//        "Victor", "Violette", "Wilfried", "Wilhelmina", "Yvon", "Yann",
//        "Zazie", "Zoé"]
//
//    static func randomName() -> String {
//        return names.randomElement()!
//    }
//
//    static func randomScore() -> Int {
//        return 10 * Int.random(in: 0...100)
//    }
//}
