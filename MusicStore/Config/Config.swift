//
//  Config.swift
//  MusicStore
//
//  Created by RNSS on 28/12/19.
//  Copyright © 2019 RNSS. All rights reserved.
//

import UIKit

public class Config {

    let dbName = "musicstore.sqlite"
    let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
    .userDomainMask,
    true).first
    let fullDestPath = URL(fileURLWithPath: destPath)
                           .appendingPathComponent(dbName)
    let fullDestPathString = fullDestPath.path
    let dbPath = fullDestPathString
    
    
    init(<#parameters#>) {
        <#statements#>
    }
}
