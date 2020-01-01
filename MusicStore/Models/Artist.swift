//
//  Artist.swift
//  MusicStore
//
//  Created by RNSS on 28/12/19.
//  Copyright © 2019 RNSS. All rights reserved.
//

import GRDB

// A plain Artist struct
struct Artist {
    // Prefer Int64 for auto-incremented database ids
    var ArtistId: Int
    var Name: String
}

// Hashable conformance supports tableView diffing
extension Artist: Hashable { }

// MARK: - Persistence

// Turn Artist into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Artist: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let ArtistId = Column(CodingKeys.ArtistId)
        static let Name = Column(CodingKeys.Name)
    }
    
    // Update a Artist id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        ArtistId = Int(rowID)
    }
}

// MARK: - Database access

// Define some useful Artist requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Artist {
    static func orderedByName() -> QueryInterfaceRequest<Artist> {
        return Artist.order(Columns.Name)
    }
    
    static func orderedByScore() -> QueryInterfaceRequest<Artist> {
        return Artist.order(Columns.ArtistId.desc, Columns.Name)
    }
}

