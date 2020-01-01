//
//  PlaylistTrack.swift
//  MusicStore
//
//  Created by RNSS on 01/01/20.
//  Copyright © 2020 RNSS. All rights reserved.
//

import GRDB

// A plain Player struct
struct PlaylistTrack {
    // Prefer Int64 for auto-incremented database ids
    var PlaylistId: Int
    var TrackId: Int
}

// Hashable conformance supports tableView diffing
extension PlaylistTrack: Hashable { }

// MARK: - Persistence

// Turn Player into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension PlaylistTrack: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let PlaylistId = Column(CodingKeys.PlaylistId)
        static let TrackId = Column(CodingKeys.TrackId)
    }
    
    // Update a player id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        PlaylistId = Int(rowID)
    }
}

// MARK: - Database access

// Define some useful player requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension PlaylistTrack {
    static func orderedByName() -> QueryInterfaceRequest<PlaylistTrack> {
        return PlaylistTrack.order(Columns.PlaylistId)
    }
    
    static func orderedByScore() -> QueryInterfaceRequest<PlaylistTrack> {
        return PlaylistTrack.order(Columns.TrackId.desc, Columns.TrackId)
    }
}

