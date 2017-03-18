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

    let worker = AppWorker()
    worker.run()

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
      NSApplication.shared().terminate(self)
    }
  }
}

