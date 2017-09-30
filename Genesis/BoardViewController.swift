//
//  ViewController.swift
//  Genesis
//
//  Created by Gerard Iglesias on 27/08/2017.
//  Copyright © 2017 Gerard Iglesias. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {

  lazy var container = {return (UIApplication.shared.delegate as? BoardAppDelegate)?.boardContainer}()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    if let model = container?.managedObjectModel {
      // here extract some features
      NSLog("managed object: %@", model)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

