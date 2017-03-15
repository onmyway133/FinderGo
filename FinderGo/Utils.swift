//
//  Utils.swift
//  FinderGo
//
//  Created by Khoa Pham on 15/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Foundation

struct Utils {

  static func run(name: String, path: String) {
    guard let scriptUrl = Bundle.main.url(forResource: name, withExtension: "script"),
      let string = try? String(contentsOf: scriptUrl) else {
        return
    }

    let source = string
      .replacingOccurrences(of: "{{PATH}}", with: path)
      .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let script = NSAppleScript(source: source)

    var executeError: NSDictionary?
    script?.executeAndReturnError(&executeError)
    print(executeError as Any)
  }
}
