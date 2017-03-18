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

  var bundle: String {
    return Bundle(for: FinderSync.self).bundleIdentifier!
  }

  var scriptPath: URL? {
    return try? FileManager.default.url(for: .applicationScriptsDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  }

  func fileScriptPath(fileName: String) -> URL? {
    return scriptPath?
      .appendingPathComponent(fileName)
      .appendingPathExtension("scpt")
  }

  func run() {
    guard let filePath = fileScriptPath(fileName: fileName) else {
      return
    }

    guard FileManager.default.fileExists(atPath: filePath.path) else {
      openPanel()
      return
    }

    guard let script = try? NSUserAppleScriptTask(url: filePath) else {
      return
    }

    script.execute(completionHandler: nil)
  }

  func openPanel() {
    let panel = NSOpenPanel()
    panel.directoryURL = scriptPath
    panel.canChooseDirectories = true
    panel.canChooseFiles = false
    panel.prompt = "Select Script Folder"
    panel.message = "Please select the User > Library > Application Scripts > \(bundle) folder"

    panel.begin { result in
      guard result == NSFileHandlingPanelOKButton,
        panel.url == self.scriptPath else {

        self.alert(message: "Script folder was not selected")
        return
      }

      let result = self.copy()
      if result {
        self.alert(message: "Done")
      } else {
        self.alert(message: "Fail")
      }
    }
  }

  func alert(message: String) {
    let alert = NSAlert()
    alert.messageText = "🐢 Finder Go"
    alert.informativeText = message
    alert.addButton(withTitle: "OK")

    alert.runModal()
  }

  func copy() -> Bool {
    let fileNames = ["terminal", "iterm", "hyper"]

    for fileName in fileNames {
      guard let path = Bundle(for: FinderSync.self).url(forResource: fileName, withExtension: "scpt"),
        let destinationPath = fileScriptPath(fileName: fileName) else {

        return false
      }

      do {
        try FileManager.default.copyItem(at: path, to: destinationPath)
      } catch {
        return false
      }
    }

    return true
  }
}
