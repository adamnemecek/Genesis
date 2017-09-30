//
//  BoardView.swift
//  Genesis
//
//  Created by Iglesias, Gérard (FircoSoft) on 28/09/2017.
//  Copyright © 2017 Gerard Iglesias. All rights reserved.
//

import UIKit

class BoardView: UIView {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    backgroundColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
  }

    override func draw(_ rect: CGRect) {
      NSLog("%@", UIBezierPath.supportsSecureCoding ? "true" : "false")
  }

}
