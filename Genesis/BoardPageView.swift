//
//  BoardPageView.swift
//  Genesis
//
//  Created by Gerard Iglesias on 01/10/2017.
//  Copyright © 2017 Gerard Iglesias. All rights reserved.
//

import UIKit
import Metal
import MetalKit
import simd

/// The Vertex structure
struct SimpleVertex {
  var position : float4
  var color : float4
}

struct Uniforms
{
  var modelViewProjectionMatrix : matrix_float4x4
};

class BoardPageView: MTKView {
  
  var camera = BoardPageCamera(center: CGPoint(x: 21.0/2.0, y: 29.7/2.0), up: CGVector(dx: 0, dy: 1.0), extend: CGSize(width: 21, height: 29.7))
  
  var mlLayer : CAMetalLayer {
    get {
      return self.layer as! CAMetalLayer
    }
  }
  
  var commandQueue: MTLCommandQueue?
  
  // MARK Data structure
  
  var vertexBuffer : MTLBuffer?
  var viewingBuffer : MTLBuffer?
  
  var library : MTLLibrary?
  var vertexFunction : MTLFunction?
  var fragmentFunction : MTLFunction?
  
  var pipelineState : MTLRenderPipelineState?
  
  // the struc to pass transformation to the shader
  var uniforms = Uniforms(modelViewProjectionMatrix: matrix_identity_float4x4)
  
  // overrides
  
  // MARK: Init Phase
  
  override init(frame frameRect: CGRect, device: MTLDevice?) {
    
    super.init(frame: frameRect, device: device)
    
    isOpaque = false
    
    preferredFramesPerSecond = 60
    
    let value = 0.5
    clearColor = MTLClearColor(red: value, green: value, blue: value, alpha: 1.0)
    clearDepth = 1.0
    clearStencil = 0
    colorPixelFormat = .bgra8Unorm
    sampleCount = 4
    
    commandQueue = self.device?.makeCommandQueue()
    
    makeBuffers()
    makePipeline()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func makeBuffers(){
    let vertices : [SimpleVertex] = [
      SimpleVertex(position: float4(0, -0.95, 0, 1), color: float4(1, 0, 0, 1)),
      SimpleVertex(position: float4(0, 0.95, 0, 1), color: float4(1, 0, 0, 1)),
      SimpleVertex(position: float4(-0.95, 0, 0, 1), color: float4(0, 0, 1, 1)),
      SimpleVertex(position: float4(0.95, 0, 0, 1), color: float4(0, 0, 1, 1))
    ]
    vertexBuffer = self.device?.makeBuffer(bytes: vertices, length: vertices.count*MemoryLayout<SimpleVertex>.stride, options: .storageModeShared)
    
    // the viewing buffer
    let viewingBufferSize = MemoryLayout<Uniforms>.size
    viewingBuffer = self.device?.makeBuffer(length: viewingBufferSize, options: .cpuCacheModeWriteCombined)
  }
  
  func makePipeline(){
    library = self.device?.makeDefaultLibrary()
    vertexFunction = library?.makeFunction(name : "vertex_main")
    fragmentFunction = library?.makeFunction(name : "fragment_main")
    
    let pipelineDescr = MTLRenderPipelineDescriptor()
    pipelineDescr.vertexFunction = vertexFunction
    pipelineDescr.fragmentFunction = fragmentFunction
    pipelineDescr.colorAttachments[0].pixelFormat = mlLayer.pixelFormat
    pipelineDescr.sampleCount = 4
    
    do {
      pipelineState = try device!.makeRenderPipelineState(descriptor: pipelineDescr)
    }
    catch {
      Swift.print(error)
    }
  }
  
  // refresh the viewing transformation
  func updateViewBuffer(){
    uniforms.modelViewProjectionMatrix = camera.projectionIn(viewport: bounds.size)
    memcpy(viewingBuffer?.contents(), &uniforms, MemoryLayout<Uniforms>.size)
  }
  // MARK: Display
  
  override func draw(_ rect : CGRect) {
    guard self.device != nil else{
      Swift.print("No device")
      return
    }
    guard self.commandQueue != nil else{
      Swift.print("No Command Queue")
      return
    }
    guard self.pipelineState != nil else{
      Swift.print("No pipeline")
      return
    }
    
    if let drawable = self.currentDrawable,
      let commandBuffer = commandQueue!.makeCommandBuffer(),
      let passDescr = self.currentRenderPassDescriptor,
      let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescr){
      
      commandEncoder.setRenderPipelineState(pipelineState!)
      
      let nativeScale = Double(UIScreen.main.nativeScale)
      let viewport = MTLViewport(originX: 0, originY: 0, width: nativeScale*Double(bounds.width), height: nativeScale*Double(bounds.height), znear: 0, zfar: 1)
      commandEncoder.setViewport(viewport)
      
      updateViewBuffer()
      
      commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
      commandEncoder.setVertexBuffer(viewingBuffer, offset: 0, index: 1)
      commandEncoder.drawPrimitives(type: .line, vertexStart: 0, vertexCount: 4)
      commandEncoder.endEncoding()
      commandBuffer.present(drawable)
      commandBuffer.commit()
    }
  }
  
  // MARK: Events
  
  override func becomeFirstResponder() -> Bool {
    return true
  }
  
  // MARK: Layouts
  
  // MARK: Archive
  
  override func awakeFromNib() {
    Swift.print(self.mlLayer.debugDescription)
  }
}
