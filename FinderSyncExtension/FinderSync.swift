//
//  FinderSync.swift
//  FinderSyncExtension
//
//  Created by Khoa Pham on 13/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync, NSMenuDelegate {

  override init() {
    super.init()

    NSLog("FinderSync() launched from %@", Bundle.main.bundlePath as NSString)
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
    menu.delegate = self

    menu.addItem(withTitle: "iTerm", action: #selector(openiTerm(_:)), keyEquivalent: "")
    menu.addItem(withTitle: "Terminal", action: #selector(openTerminal(_:)), keyEquivalent: "")
    menu.addItem(withTitle: "Hyper", action: #selector(openHyper(_:)), keyEquivalent: "")

    return menu
  }

  // MARK: - NSMenuDelegate

  func menuWillOpen(_ menu: NSMenu) {
    guard let targetedUrl = FIFinderSyncController.default().targetedURL() else {
      return
    }

    let board = NSPasteboard.general()
    board.setString(targetedUrl.path, forType: NSPasteboardTypeString)
  }

  // MARK: - Action

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
    guard let targetedUrl = FIFinderSyncController.default().targetedURL() else {
      return
    }

    Utils.run(name: name, path: targetedUrl.path)
  }
}

