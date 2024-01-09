//
//  File.swift
//  
//
//  Created by Lorenzo Ferrante on 09/01/24.
//

import Foundation
import os

class AppLogger: NSObject {
    
    static let shared: AppLogger = AppLogger()
    
    private let defaultLogger = Logger()
    
    private override init() {}
    
    public func log(_ msg: String, level: OSLogType, className: String?, function: String?) {
        let debugMsg = "\(className ?? "No Class name").\(function ?? "No function")\n\(msg)"
        defaultLogger.log(level: level, "\(debugMsg)")
    }
    
}

