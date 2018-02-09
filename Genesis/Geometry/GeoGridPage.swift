//
//  GoeGridPage.swift
//  Genesis
//
//  Created by Gerard Iglesias on 04/11/2017.
//  Copyright © 2017 Gerard Iglesias. All rights reserved.
//

import Foundation
import Metal
import MetalKit
import simd

class GeoPageGrid : MTKMesh {
  
  init?(pageFormat: CGSize, device: MTLDevice) throws {
    let gridMesh = MDLMesh()
    // create the corresponding Meshes
    try? super.init(mesh: gridMesh, device: device)
  }
  
}
