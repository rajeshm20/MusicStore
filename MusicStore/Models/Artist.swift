//
//  Artist.swift
//  MusicStore
//
//  Created by RNSS on 28/12/19.
//  Copyright © 2019 RNSS. All rights reserved.
//

import GRDB

// A plain Player struct
struct Artist {
    // Prefer Int64 for auto-incremented database ids
    var ArtistId: Int
    var Name: String
}

// Hashable conformance supports tableView diffing
extension Artist: Hashable { }

// MARK: - Persistence

// Turn Player into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Artist: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let ArtistId = Column(CodingKeys.ArtistId)
        static let Name = Column(CodingKeys.Name)
    }
    
    // Update a player id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        ArtistId = Int(rowID)
    }
}

// MARK: - Database access

// Define some useful player requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Artist {
    static func orderedByName() -> QueryInterfaceRequest<Artist> {
        return Artist.order(Columns.Name)
    }
    
    static func orderedByScore() -> QueryInterfaceRequest<Artist> {
        return Artist.order(Columns.ArtistId.desc, Columns.Name)
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
