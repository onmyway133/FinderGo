//
//  ExtensionWorker.swift
//  FinderGo
//
//  Created by Khoa Pham on 18/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

struct ExtensionWorker {

  let fileName: String
  let path: String

  init(path: String, fileName: String) {
    self.path = path
    self.fileName = fileName
  }

  func run() {
    guard let scriptUrl = Bundle.main.url(forResource: fileName, withExtension: "script"),
      let string = try? String(contentsOf: scriptUrl) else {
        return
    }

    let source = string
      .replacingOccurrences(of: "{{PATH}}", with: path)
      .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let script = NSAppleScript(source: source)

    var executeError: NSDictionary?
    script?.executeAndReturnError(&executeError)

    if executeError != nil {
      print(executeError as Any)
    }
  }
}
