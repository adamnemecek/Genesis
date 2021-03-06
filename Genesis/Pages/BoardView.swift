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
  var current = 0
  
  let device = MTLCreateSystemDefaultDevice()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    guard device != nil else { return }
    backgroundColor = UIColor(white: 0.666, alpha: 1.0)
    let firstPage = BoardPageView(frame: CGRect(x: 0, y: 0, width: A4.width, height: A4.height), device: device)
    pages.append(firstPage)
    addSubview(pages[0])
  }

  override func draw(_ rect: CGRect) {
    NSLog("%@", UIBezierPath.supportsSecureCoding ? "true" : "false")
  }

  override func layoutSubviews() {
    pages[0].frame = layoutPage(pos: 0, nbPages: 1)
  }

  /// For now just one page
  ///
  /// - Parameters:
  ///   - pos: position of the pages in the book
  ///   - nbPages: number of pages in the book
  func layoutPage(pos: Int, nbPages: Int) -> CGRect {
    let pageFormat = pages[pos].pageFormat
    let scale: CGFloat = 1.00
    let safeframe = UIEdgeInsetsInsetRect(bounds, safeAreaInsets)
    func center(width: CGFloat, height: CGFloat) -> CGRect {
      let left = safeframe.origin.x + (safeframe.width - width) / 2.0
      let bottom = safeframe.origin.y + (safeframe.height - height) / 2.0
      return CGRect(x: left, y: bottom, width: width, height: height)
    }
    if safeframe.width > safeframe.height {
      let height = safeframe.height * scale
      let width = (height * pageFormat.width) / pageFormat.height
      return center(width: width, height: height)
    }
    else {
      let height = safeframe.height * scale
      let width = height * pageFormat.width / pageFormat.height
      return center(width: width, height: height)
    }
  }

  @IBAction func toggleGrid(_ sender: Any) {
    pages[current].showGrid = !pages[current].showGrid
  }
}
