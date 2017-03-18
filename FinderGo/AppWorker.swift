//
//  AppWorker.swift
//  FinderGo
//
//  Created by Khoa Pham on 15/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

struct AppWorker {

  func finderCurrentPath() -> String? {
    guard let scriptUrl = Bundle.main.url(forResource: "finderCurrentPath", withExtension: "scpt"),
      let string = try? String(contentsOf: scriptUrl) else {
        return nil
    }

    let script = NSAppleScript(source: string)
    return script?.executeAndReturnError(nil).stringValue
  }

  func run() {
    guard let path = finderCurrentPath() else {
      return
    }

    let process = Process()
    process.launchPath = "/usr/bin/open"
    process.arguments = ["-a", "iTerm", "\(path)"]

    process.launch()
    process.waitUntilExit()
  }
}
