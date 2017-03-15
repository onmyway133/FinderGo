//
//  ViewController.swift
//  FinderGo
//
//  Created by Khoa Pham on 13/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    Utils.open()
    NSApplication.shared().terminate(self)
  }
}

