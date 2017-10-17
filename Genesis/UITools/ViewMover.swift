//
//  ViewMover.swift
//  Genesis
//
//  Created by Gerard Iglesias on 17/10/2017.
//  Copyright © 2017 Gerard Iglesias. All rights reserved.
//

import UIKit

class ViewMover: NSObject {

  var originalCenter = CGPoint(x: 0, y: 0)
  
  @IBAction func panView(_ gestureRecognizer : UIPanGestureRecognizer) {
    if let piece = gestureRecognizer.view {
      switch gestureRecognizer.state {
      case .began:
        originalCenter = piece.center
      case .changed:
        let translation = gestureRecognizer.translation(in: piece.superview)
        piece.center = CGPoint(x: originalCenter.x + translation.x,
                               y: originalCenter.y + translation.y)
      default:
        break
      }
    }
  }

}
