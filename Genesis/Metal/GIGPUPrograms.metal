//
//  GIGPUPrograms.metal
//  Chapter3
//
//  Created by Gerard Iglesias on 07/12/2016.
//  Copyright © 2016 Gerard Iglesias. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct Vertex {
  float4 position [[position]];
  float4 color;
};

struct Uniforms
{
  float4x4 modelViewProjectionMatrix;
};

vertex Vertex vertex_main(device Vertex *vertices [[buffer(0)]], constant Uniforms *uniforms [[buffer(1)]], uint vid [[vertex_id]])
{
  Vertex vertexOut;
  vertexOut.position = uniforms->modelViewProjectionMatrix * vertices[vid].position;
  vertexOut.color = vertices[vid].color;
  return vertexOut;
}

fragment float4 fragment_main(Vertex inVertex [[stage_in]])
{
  return inVertex.color;
}
