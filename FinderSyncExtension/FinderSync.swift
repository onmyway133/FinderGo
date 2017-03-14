//
//  FinderSync.swift
//  FinderSyncExtension
//
//  Created by Khoa Pham on 13/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {

  var myFolderURL = URL(fileURLWithPath: "/Users/Shared/MySyncExtension Documents")

  override init() {
    super.init()

    NSLog("FinderSync() launched from %@", Bundle.main.bundlePath as NSString)

    // Set up the directory we are syncing.
    FIFinderSyncController.default().directoryURLs = [self.myFolderURL]

    // Set up images for our badge identifiers. For demonstration purposes, this uses off-the-shelf images.
    FIFinderSyncController.default().setBadgeImage(NSImage(named: NSImageNameColorPanel)!, label: "Status One" , forBadgeIdentifier: "One")
    FIFinderSyncController.default().setBadgeImage(NSImage(named: NSImageNameCaution)!, label: "Status Two", forBadgeIdentifier: "Two")
  }

  // MARK: - Primary Finder Sync protocol methods

  override func beginObservingDirectory(at url: URL) {
    // The user is now seeing the container's contents.
    // If they see it in more than one view at a time, we're only told once.
    NSLog("beginObservingDirectoryAtURL: %@", url.path as NSString)
  }


  override func endObservingDirectory(at url: URL) {
    // The user is no longer seeing the container's contents.
    NSLog("endObservingDirectoryAtURL: %@", url.path as NSString)
  }

  override func requestBadgeIdentifier(for url: URL) {
    NSLog("requestBadgeIdentifierForURL: %@", url.path as NSString)

    // For demonstration purposes, this picks one of our two badges, or no badge at all, based on the filename.
    let whichBadge = abs(url.path.hash) % 3
    let badgeIdentifier = ["", "One", "Two"][whichBadge]
    FIFinderSyncController.default().setBadgeIdentifier(badgeIdentifier, for: url)
  }

  // MARK: - Menu and toolbar item support

  override var toolbarItemName: String {
    return "FinderGo"
  }

  override var toolbarItemToolTip: String {
    return "FinderGo: Click the toolbar item for a menu."
  }

  override var toolbarItemImage: NSImage {
    return NSImage(named: "barIcon")!
  }

  override func menu(for menuKind: FIMenuKind) -> NSMenu {
    let menu = NSMenu(title: "")

    menu.addItem(withTitle: "iTerm", action: #selector(openiTerm(_:)), keyEquivalent: "")
    menu.addItem(withTitle: "Terminal", action: #selector(openTerminal(_:)), keyEquivalent: "")
    menu.addItem(withTitle: "Hyper", action: #selector(openHyper(_:)), keyEquivalent: "")

    return menu
  }

  @IBAction func openiTerm(_ sender: AnyObject?) {
    run(name: "iterm")
  }

  @IBAction func openTerminal(_ sender: AnyObject?) {
    run(name: "terminal")
  }

  @IBAction func openHyper(_ sender: AnyObject?) {
    run(name: "hyper")
  }

  // MARK: - Script

  func run(name: String) {
    guard let scriptUrl = Bundle.main.url(forResource: name, withExtension: "script"),
      let string = try? String(contentsOf: scriptUrl),
      let targetedUrl = FIFinderSyncController.default().targetedURL() else {
      return
    }

    let source = string
      .replacingOccurrences(of: "{{PATH}}", with: targetedUrl.path)
      .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let script = NSAppleScript(source: source)

    var executeError: NSDictionary?
    script?.executeAndReturnError(&executeError)
    print(executeError as Any)
  }
}

