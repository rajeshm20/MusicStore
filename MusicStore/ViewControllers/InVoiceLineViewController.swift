//
//  InVoiceLineViewController.swift
//  MusicStore
//
//  Created by RNSS on 04/02/20.
//  Copyright © 2020 RNSS. All rights reserved.
//

import UIKit

class InVoiceLineViewController: UIViewController {
    
    var tracks = [Track]()
    var invoice = [Invoice]()
    var customers = [Customer]()
    var invoiceLine = [InvoiceLine]()
    
    var operation = Operation()
    var start: Date!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        start = Date()
        print("StartTime: \(String(describing: start))")
        let operation1 = BlockOperation {
            
            print("Querying InvoiceLine from DB is starting")
            Thread.sleep(forTimeInterval: 1)
            self.getInvoiceLineFromDB()
            let elapsed = Date().timeIntervalSince(self.start)
            print("Querying InvoiceLine from DB finishing(\(elapsed))")
        }
        
        let operation2 = BlockOperation {
            print("Querying Invoice from DB is starting")
            Thread.sleep(forTimeInterval: 1)
            self.getInvoiceFromDB()
            let elapsed = Date().timeIntervalSince(self.start)
            print("Querying Invoice from DB is finishing(\(elapsed))")
        }
        operation2.addDependency(operation1)
        
        let operation3 = BlockOperation {
            print("Querying Customers from DB is starting")
            Thread.sleep(forTimeInterval: 1)
            self.getCustomersFromDB()
            let elapsed = Date().timeIntervalSince(self.start)
            print("Querying Customers from DB is finishing(\(elapsed))")
        }
        
        operation3.addDependency(operation2)
        
        let operation4 = BlockOperation {
            print("Querying Tracks from DB is starting")
            Thread.sleep(forTimeInterval: 1)
            self.getTrackFromDB()
            let elapsed = Date().timeIntervalSince(self.start)
            print("Querying Tracks from DB is finishing(\(elapsed))")
        }
        
        operation4.addDependency(operation3)

        
        print("Adding operations")
        
        let queue = OperationQueue()
        queue.addOperation(operation1)
        queue.addOperation(operation2)
        queue.addOperation(operation3)
        queue.waitUntilAllOperationsAreFinished()
        
        print("Done!")
    }
    
    // Querying InvoiceLine data from db

    func getInvoiceLineFromDB(){
        do{
            try dbQueue.read { db in
                invoiceLine = try InvoiceLine.fetchAll(db)
                print("all invoiceLine: ", invoiceLine)
            }
        } catch {
            print("db error: \(error)")
        }
    }
    
    // Querying Customer data from db
    func getCustomersFromDB(){
        do{
            try dbQueue.read { db in
                customers = try Customer.fetchAll(db)
                print("all customers: ", customers)
            }
        } catch {
            print("db error: \(error)")
        }
    }
    
    
    // Querying invoice data from db
    func getInvoiceFromDB(){
        do{
            try dbQueue.read { db in
                invoice = try Invoice.fetchAll(db)
                print("all invoice: ", invoice)
            }
        } catch {
            print("db error: \(error)")
        }
    }
    
    
    // Querying track data from db
    func getTrackFromDB(){
        do{
            try dbQueue.read { db in
                tracks = try Track.fetchAll(db)
                print("all tracks: ", tracks)
            }
        } catch {
            print("db error: \(error)")
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
