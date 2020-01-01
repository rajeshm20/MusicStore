import GRDB

// A plain Album struct
struct Album {
    // Prefer Int64 for auto-incremented database ids
    var AlbumId: Int
    var Title: String
    var ArtistId: Int
}

// Hashable conformance supports tableView diffing
extension Album: Hashable { }

// MARK: - Persistence

// Turn Album into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Album: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let AlbumId = Column(CodingKeys.AlbumId)
        static let Title = Column(CodingKeys.Title)
        static let ArtistId = Column(CodingKeys.ArtistId)
    }
    
    // Update a Album id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        AlbumId = Int(rowID)
    }
}

// MARK: - Database access

// Define some useful Album requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Album {
    static func orderedByArtistID() -> QueryInterfaceRequest<Album> {
        return Album.order(Columns.ArtistId, Columns.Title)
    }
    
    static func orderedByAlbumID() -> QueryInterfaceRequest<Album> {
        return Album.order(Columns.AlbumId.desc, Columns.Title)
    }
}

