//
//  Artist.swift
//  MusicStore
//
//  Created by RNSS on 28/12/19.
//  Copyright © 2019 RNSS. All rights reserved.
//

import GRDB

// A plain Player struct
struct Track {
    // Prefer Int64 for auto-incremented database ids
    var TrackId: Int
    var Name: String
    var AlbumId: Int
    var MediaTypeId: Int
    var GenreId: Int
    var Composer: String
    var Milliseconds: Int
    var Bytes: Int
    var UnitPrice: Int
    

}

// Hashable conformance supports tableView diffing
extension Track: Hashable { }

// MARK: - Persistence

// Turn Player into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Track: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let TrackId = Column(CodingKeys.TrackId)
        static let Name = Column(CodingKeys.Name)
        static let AlbumId = Column(CodingKeys.TrackId)
        static let MediaTypeId = Column(CodingKeys.TrackId)
        static let GenreId = Column(CodingKeys.GenreId)
        static let Composer = Column(CodingKeys.Composer)
        static let Milliseconds = Column(CodingKeys.Milliseconds)
        static let Bytes = Column(CodingKeys.Bytes)
        static let UnitPrice = Column(CodingKeys.UnitPrice)

    }
    
    // Update a player id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        TrackId = Int(rowID)
    }
}

// MARK: - Database access

// Define some useful player requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Track {
    static func orderedByName() -> QueryInterfaceRequest<Track> {
        return Track.order(Columns.Name)
    }
    
    static func orderedByScore() -> QueryInterfaceRequest<Track> {
        return Track.order(Columns.TrackId.desc, Columns.Name)
    }
}

