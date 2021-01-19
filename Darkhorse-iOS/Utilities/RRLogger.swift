//
//  RRLogger.swift
//  Rooted MessagesExtension
//
//  Created by Michael Westbrooks on 2/26/20.
//  Copyright © 2020 RedRooster Technologies Inc. All rights reserved.
//

import Foundation

class RRLogger {
  static func log(message: String, owner: Any) {
    NSLog("[\(Bundle.main.bundleIdentifier ?? kAppName)] \(String(describing: owner)): \(message)")
  }

  static func logError(message: String, owner: Any, error: Error) {
    NSLog("[\(Bundle.main.bundleIdentifier ?? kAppName)] RRLogger - \(String(describing: owner)): \(message) Error description: \(error.localizedDescription)")
  }

//  static func logError(message: String, owner: Any, rError: RError) {
//    NSLog("[\(Bundle.main.bundleIdentifier ?? kAppName)] RRLogger - \(String(describing: owner)): \(message) Error description: \(rError.localizedDescription)")
//  }
}

public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
  #if DEBUG
  guard let object = object else { return }
  print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
  #endif
}
