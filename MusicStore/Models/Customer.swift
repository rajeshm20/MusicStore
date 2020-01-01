//
//  Customer.swift
//  MusicStore
//
//  Created by RNSS on 01/01/20.
//  Copyright © 2020 RNSS. All rights reserved.
//


import GRDB

// A plain Player struct
struct Customer {
    // Prefer Int64 for auto-incremented database ids
    var CustomerId: Int
    var LastName: String
    var FirstName: String
    var Company: String
    var Address: String
    var City: String
    var State: String
    var Country: String
    var PostalCode: String
    var Phone: String
    var Fax: String
    var Email: String
    var SupportRepId: Int

}

// Hashable conformance supports tableView diffing
extension Customer: Hashable { }

// MARK: - Persistence

// Turn Player into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Customer: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys

    private enum Columns {
        static let CustomerId = Column(CodingKeys.CustomerId)
        static let LastName = Column(CodingKeys.LastName)
        static let FirstName = Column(CodingKeys.FirstName)
        static let Company = Column(CodingKeys.Company)
        static let Address = Column(CodingKeys.Address)
        static let City = Column(CodingKeys.City)
        static let State = Column(CodingKeys.State)
        static let Country = Column(CodingKeys.Country)
        static let PostalCode = Column(CodingKeys.PostalCode)
        static let Phone = Column(CodingKeys.Phone)
        static let Fax = Column(CodingKeys.Fax)
        static let Email = Column(CodingKeys.Email)
        static let SupportRepId = Column(CodingKeys.SupportRepId)

    }
    
    // Update a player id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        CustomerId = Int(rowID)
    }
}

// MARK: - Database access

// Define some useful player requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Customer {
    static func orderedByFirstName() -> QueryInterfaceRequest<Customer> {
        return Customer.order(Columns.FirstName)
    }
    
    static func orderedByEmployeeID() -> QueryInterfaceRequest<Customer> {
        return Customer.order(Columns.CustomerId.desc, Columns.FirstName)
    }
}

