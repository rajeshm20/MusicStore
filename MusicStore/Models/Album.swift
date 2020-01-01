import GRDB

// A plain Player struct
struct Album {
    // Prefer Int64 for auto-incremented database ids
    var AlbumId: Int
    var Title: String
    var ArtistId: Int
}

// Hashable conformance supports tableView diffing
extension Album: Hashable { }

// MARK: - Persistence

// Turn Player into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Album: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let AlbumId = Column(CodingKeys.AlbumId)
        static let Title = Column(CodingKeys.Title)
        static let ArtistId = Column(CodingKeys.ArtistId)
    }
    
    // Update a player id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        AlbumId = Int(rowID)
    }
}

// MARK: - Database access

// Define some useful player requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Album {
    static func orderedByName() -> QueryInterfaceRequest<Album> {
        return Album.order(Columns.Title)
    }
    
    static func orderedByScore() -> QueryInterfaceRequest<Album> {
        return Album.order(Columns.AlbumId.desc, Columns.Title)
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
