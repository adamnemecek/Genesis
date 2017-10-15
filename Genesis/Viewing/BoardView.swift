//
//  BoardView.swift
//  Genesis
//
//  Created by Iglesias, Gérard (FircoSoft) on 28/09/2017.
//  Copyright © 2017 Gerard Iglesias. All rights reserved.
//

import UIKit

/// Will organize the layout of the document pages
class BoardView: UIView {

  var pages = [BoardPageView]()
  
  let device = MTLCreateSystemDefaultDevice()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    guard device != nil else { return }
    backgroundColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    let pageRect = layoutPage(pos: 0, nbPages: 1)
    let firstPage = BoardPageView(frame: pageRect, device: device)
    pages.append(firstPage)
    addSubview(pages[0])
  }

  override func draw(_ rect: CGRect) {
    NSLog("%@", UIBezierPath.supportsSecureCoding ? "true" : "false")
  }

  override func layoutSubviews() {
    pages[0].frame = layoutPage(pos: 0, nbPages: 1)
  }

  /// For now just 0ne page
  ///
  /// - Parameters:
  ///   - pos: position of the pages in the book
  ///   - nbPages: number of pages in the book
  func layoutPage(pos: Int, nbPages: Int) -> CGRect {
    func center(width: CGFloat, height: CGFloat) -> CGRect {
      let left = (frame.width - width) / 2.0
      let bottom = (frame.height - height) / 2.0
      return CGRect(x: left, y: bottom, width: width, height: height)
    }
    if frame.width > frame.height {
      let height = frame.height * 0.95
      let width = height * 21 / 29.7
      return center(width: width, height: height)
    } else {
      let height = frame.height * 0.95
      let width = height * 21 / 29.7
      return center(width: width, height: height)
    }
  }
}
