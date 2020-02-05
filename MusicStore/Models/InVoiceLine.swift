//
//  InVoiceLine.swift
//  MusicStore
//
//  Created by RNSS on 01/01/20.
//  Copyright © 2020 RNSS. All rights reserved.
//

import GRDB


// A plain InvoiceLine struct
struct InvoiceLine {
    // Prefer Int64 for auto-incremented database ids
    var InvoiceLineId: Int64
    var InvoiceId: Int
    var TrackId: Int
    var UnitPrice: Int
    var Quantity: Int
    
}

// Hashable conformance supports tableView diffing
extension InvoiceLine: Hashable { }

// MARK: - Persistence

// Turn InvoiceLine into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension InvoiceLine: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        static let InvoiceLineId = Column(CodingKeys.InvoiceLineId)
        static let InvoiceId = Column(CodingKeys.InvoiceId)
        static let TrackId = Column(CodingKeys.TrackId)
        static let UnitPrice = Column(CodingKeys.UnitPrice)
        static let Quantity = Column(CodingKeys.Quantity)

    }
    
    // Update a InvoiceLine id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        InvoiceLineId = rowID
    }
}

// MARK: - Database access

// Define some useful InvoiceLine requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension InvoiceLine {
    static func orderedByLineID() -> QueryInterfaceRequest<InvoiceLine> {
        return InvoiceLine.order(Columns.InvoiceLineId)
    }
    
    static func orderedByQuantity() -> QueryInterfaceRequest<InvoiceLine> {
        return InvoiceLine.order(Columns.Quantity.desc)
    }
    
    static func orderedByPrice() -> QueryInterfaceRequest<InvoiceLine> {
        return InvoiceLine.order(Columns.UnitPrice.desc)
    }
    static func orderedByInvoiceID() -> QueryInterfaceRequest<InvoiceLine> {
        return InvoiceLine.order(Columns.InvoiceId.desc)
    }

}

