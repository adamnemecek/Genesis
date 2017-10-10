//
//  BoarPageCamera.swift
//  Genesis
//
//  Created by Gerard Iglesias on 04/10/2017.
//  Copyright © 2017 Gerard Iglesias. All rights reserved.
//

import UIKit
import simd


/// A Board camera is defined by a center position, ectens in X and Y axis
/// and a direction of the Up axix (Y)
/// The computation of the mapping projection from the space defined by the camera to the
/// Metal View space need to adapt the viewed space to keep same aspect ratio
class BoardPageCamera {
  
  var center: CGPoint
  var up: CGVector
  var extend: CGSize
  
  init(center: CGPoint, up: CGVector, extend: CGSize) {
    self.center = center
    self.up = up
    self.extend = extend
  }
  
  /// Compute the projection matrix from the camera zone to the given viewport
  /// The transformation adapt the viewed zone in order to keep the 1:1 aspect ratio
  /// and to view all the desired camera extend
  ///
  /// - Parameter viewport: the size of the MTKView
  /// - Returns: return a 4x4 matrix from virtual space to the canonical metal space
  func projectionIn(viewport: CGSize) -> matrix_float4x4 {
    // first we have to compute in what zone of [-1,1]X[-1,1] we have to map the extend zone
    // for that we need to compare the aspect ratio between the extend zone of the camera and the viewport
    // we need to alter the extend zone during this compute to get the aspect ratio match when projected in the
    // canonical Metal space
    
    // compute theoritical offset and accept values only positive
    let offsetH = max(0.0, (extend.width * viewport.height / viewport.width) - extend.height)
    let offsetW = max(0.0, (extend.height * viewport.width / viewport.height) - extend.width)
    
    // new extends
    let extendH = extend.height + offsetH
    let extendW = extend.width + offsetW
    
    // I use the usual trick, express the orthonormal referential from where the workd is see
    // as a matrix which transform from the camera world to the canonical one
    // then invert this matrix to get the opposite effect
    
    let kp = float3(0.0, 0.0, 1.0)
    let jp = normalize(float3(Float(up.dx), Float(up.dy), 0.0))
    let ip = cross(jp, kp)
    
    let toCamRef = float4x4(float4(ip.x, ip.y, ip.z, 0.0), float4(jp.x, jp.y, jp.z, 0.0), float4(0.0, 0.0, 1.0, 0.0), float4(0.0, 0.0, 0.0, 1.0))
    let toCamCenter = float4x4(float4(1.0, 0.0, 0.0, 0.0), float4(0.0, 1.0, 0.0, 0.0), float4(0.0, 0.0, 1.0, 0.0), float4(Float(-center.x), Float(-center.y), 0.0, 1.0))
    let toCamSpace = toCamRef * toCamCenter
    
    // then scale the x and y axix to get everything in a 2x2 centered square...
    let toMetalSpace = float4x4(diagonal: float4(2.0 / Float(extendW), 2.0 / Float(extendH), 1.0, 1.0))
    
    return toMetalSpace * toCamSpace
  }
}
