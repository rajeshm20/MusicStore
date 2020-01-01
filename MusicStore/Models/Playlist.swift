//
//  Playlist.swift
//  MusicStore
//
//  Created by RNSS on 01/01/20.
//  Copyright © 2020 RNSS. All rights reserved.
//

import GRDB

// A plain Playlist struct
struct Playlist {
    // Prefer Int64 for auto-incremented database ids
    var PlaylistId: Int
    var Name: String
}

// Hashable conformance supports tableView diffing
extension Playlist: Hashable { }

// MARK: - Persistence

// Turn Playlist into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Playlist: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let PlaylistId = Column(CodingKeys.PlaylistId)
        static let Name = Column(CodingKeys.Name)
    }
    
    // Update a Playlist id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        PlaylistId = Int(rowID)
    }
}

// MARK: - Database access

// Define some useful Playlist requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Playlist {
    static func orderedByID() -> QueryInterfaceRequest<Playlist> {
        return Playlist.order(Columns.PlaylistId)
    }
    
    static func orderedByName() -> QueryInterfaceRequest<Playlist> {
        return Playlist.order(Columns.Name.desc, Columns.Name)
    }
}

