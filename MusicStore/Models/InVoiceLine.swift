//
//  InVoiceLine.swift
//  MusicStore
//
//  Created by RNSS on 01/01/20.
//  Copyright © 2020 RNSS. All rights reserved.
//

import GRDB


// A plain Player struct
struct InvoiceLine {
    // Prefer Int64 for auto-incremented database ids
    var InvoiceLineId: Int
    var InvoiceId: Int
    var TrackId: Int
    var UnitPrice: Int
    var Quantity: Int
    var Bytes: Int
    
}

// Hashable conformance supports tableView diffing
extension InvoiceLine: Hashable { }

// MARK: - Persistence

// Turn Player into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension InvoiceLine: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let InvoiceLineId = Column(CodingKeys.InvoiceLineId)
        static let InvoiceId = Column(CodingKeys.InvoiceId)
        static let TrackId = Column(CodingKeys.TrackId)
        static let UnitPrice = Column(CodingKeys.UnitPrice)
        static let Quantity = Column(CodingKeys.Quantity)
        static let Bytes = Column(CodingKeys.Bytes)

    }
    
    // Update a player id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        InvoiceLineId = Int(rowID)
    }
}

// MARK: - Database access

// Define some useful player requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension InvoiceLine {
    static func orderedByLineID() -> QueryInterfaceRequest<InvoiceLine> {
        return InvoiceLine.order(Columns.InvoiceLineId)
    }
    
    static func orderedByTrackID() -> QueryInterfaceRequest<InvoiceLine> {
        return InvoiceLine.order(Columns.TrackId.desc, Columns.InvoiceId)
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
