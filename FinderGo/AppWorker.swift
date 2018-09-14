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

  func findTerminal() -> String {
    return UserDefaults.standard.string(forKey: "terminal") ?? "iTerm"
  }

  func run() {
    guard let path = finderCurrentPath() else {
      return
    }

    let process = Process()
    let terminal = findTerminal()
    process.launchPath = "/usr/bin/open"
    process.arguments = ["-a", terminal, "\(path)"]

    process.launch()
    process.waitUntilExit()
  }
}
