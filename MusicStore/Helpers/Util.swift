//
//  Util.swift
//  MusicStore
//
//  Created by RNSS on 28/12/19.
//  Copyright © 2019 RNSS. All rights reserved.
//
import Foundation
import UIKit
import GRDB

public class Util {
    
    func getDbPathString() -> String {
        let fileManager = FileManager.default
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                            .userDomainMask,
                            true).first
        let fileName = Config().DBNAME
        let fullDestPath = URL(fileURLWithPath: destPath!)
                               .appendingPathComponent(fileName)
        let fullDestPathString = fullDestPath.path

        if fileManager.fileExists(atPath: fullDestPathString) {
            
            return fullDestPathString
        }

    }
}


