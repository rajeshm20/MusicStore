//
//  Employee.swift
//  MusicStore
//
//  Created by RNSS on 01/01/20.
//  Copyright © 2020 RNSS. All rights reserved.
//
import GRDB

// A plain Employee struct
struct Employee {
    // Prefer Int64 for auto-incremented database ids
    var EmployeeId: Int64
    var LastName: String
    var FirstName: String
    var Title: String
    var ReportsTo: Int
    var BirthDate: Date
    var HireDate: Date
    var Address: String
    var City: String
    var State: String
    var Country: String
    var PostalCode: String
    var Phone: String
    var Fax: String
    var Email: String
    

}

// Hashable conformance supports tableView diffing
extension Employee: Hashable { }

// MARK: - Persistence

// Turn Employee into a Codable Record.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#records
extension Employee: Codable, FetchableRecord, MutablePersistableRecord {
    // Define database columns from CodingKeys

    private enum Columns {
        static let EmployeeId = Column(CodingKeys.EmployeeId)
        static let LastName = Column(CodingKeys.LastName)
        static let FirstName = Column(CodingKeys.FirstName)
        static let Title = Column(CodingKeys.Title)
        static let ReportsTo = Column(CodingKeys.ReportsTo)
        static let BirthDate = Column(CodingKeys.BirthDate)
        static let HireDate = Column(CodingKeys.HireDate)
        static let Address = Column(CodingKeys.Address)
        static let City = Column(CodingKeys.City)
        static let State = Column(CodingKeys.State)
        static let Country = Column(CodingKeys.Country)
        static let PostalCode = Column(CodingKeys.PostalCode)
        static let Phone = Column(CodingKeys.Phone)
        static let Fax = Column(CodingKeys.Fax)
        static let Email = Column(CodingKeys.Email)

    }
    
    // Update a Employee id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        EmployeeId = rowID
    }
}

// MARK: - Database access

// Define some useful query requests.
// See https://github.com/groue/GRDB.swift/blob/master/README.md#requests
extension Employee {
    static func orderedByFirstName() -> QueryInterfaceRequest<Employee> {
        return Employee.order(Columns.FirstName)
    }
    
    static func orderedByEmployeeID() -> QueryInterfaceRequest<Employee> {
        return Employee.order(Columns.EmployeeId.desc)
    }
}

