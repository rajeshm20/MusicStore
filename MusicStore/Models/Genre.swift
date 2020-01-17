
//
//  Genre.swift
//  MusicStore
//
//  Created by RNSS on 01/01/20.
//  Copyright © 2020 RNSS. All rights reserved.
//

import GRDB

// A plain Genre struct
struct Genre {
    // Prefer Int64 for auto-incremented database ids
    var GenreId: Int64
    var Name: String
}

// Hashable conformance supports tableView diffing
extension Genre: Hashable { }

// MARK: - Persistence

// Turn Genre into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Genre: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let GenreId = Column(CodingKeys.GenreId)
        static let Name = Column(CodingKeys.Name)
    }
    
    // Update a Genre id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        GenreId = rowID
    }
}

// MARK: - Database access

// Define some useful Genre requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Genre {
    static func orderedByGenreID() -> QueryInterfaceRequest<Genre> {
        return Genre.order(Columns.GenreId)
    }
    
    static func orderedByName() -> QueryInterfaceRequest<Genre> {
        return Genre.order(Columns.GenreId.desc, Columns.Name)
    }
}

