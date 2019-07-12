//
//  VertexDrawMode_TRIANGLE_STRIP_ViewController.m
//  OpenGLZeroStudyDemo(2)
//
//  Created by glodon on 2019/7/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "VertexDrawMode_TRIANGLE_STRIP_ViewController.h"

@interface VertexDrawMode_TRIANGLE_STRIP_ViewController ()

@end

@implementation VertexDrawMode_TRIANGLE_STRIP_ViewController
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [super glkView:view drawInRect:rect];
    [self.vertex drawVertexWithMode:GL_TRIANGLE_STRIP startVertexIndex:0 numberOfVertices:VertexNum];
    
}

@end
