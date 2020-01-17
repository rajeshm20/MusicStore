//
//  Invoice.swift
//  
//
//  Created by RNSS on 01/01/20.
//

import GRDB


// A plain Invoice struct
struct Invoice {
    // Prefer Int64 for auto-incremented database ids
    var InvoiceId: Int64
    var CustomerId: Int
    var InvoiceDate: Date
    var BillingAddress: String
    var BillingCity: String
    var BillingState: String
    var BillingCountry: String
    var BillingPostalCode: String
    var Total: Float
    
}

// Hashable conformance supports tableView diffing
extension Invoice: Hashable { }

// MARK: - Persistence

// Turn Invoice into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Invoice: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys
    private enum Columns {
        
        static let InvoiceId = Column(CodingKeys.InvoiceId)
        static let CustomerId = Column(CodingKeys.CustomerId)
        static let InvoiceDate = Column(CodingKeys.InvoiceDate)
        static let BillingAddress = Column(CodingKeys.BillingAddress)
        static let BillingCity = Column(CodingKeys.BillingCity)
        static let BillingState = Column(CodingKeys.BillingState)
        static let BillingCountry = Column(CodingKeys.BillingCountry)
        static let BillingPostalCode = Column(CodingKeys.BillingPostalCode)
        static let Total = Column(CodingKeys.Total)

    }
    
    // Update a Invoice id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        InvoiceId = rowID
    }
}

// MARK: - Database access

// Define some useful Invoice requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Invoice {
    static func orderedByInvoiceID() -> QueryInterfaceRequest<Invoice> {
        return Invoice.order(Columns.InvoiceId)
    }
    
    static func orderedByCustomerID() -> QueryInterfaceRequest<Invoice> {
        return Invoice.order(Columns.CustomerId.desc)
    }
}

