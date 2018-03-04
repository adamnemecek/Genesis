//
//  PageFormat.swift
//  Genesis
//
//  Created by Gerard Iglesias on 04/03/2018.
//  Copyright © 2018 Gerard Iglesias. All rights reserved.
//

import CoreGraphics

struct PageFormat: Equatable {
  let width: CGFloat
  let height: CGFloat
}

let A4 = PageFormat(width: 21.0, height: 29.7)
let Letter = PageFormat(width: 21.59, height: 27.94)
