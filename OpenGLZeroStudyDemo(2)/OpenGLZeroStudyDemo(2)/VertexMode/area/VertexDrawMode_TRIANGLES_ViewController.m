//
//  VertexDrawMode_TRIANGLES_ViewController.m
//  OpenGLZeroStudyDemo(2)
//
//  Created by glodon on 2019/7/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "VertexDrawMode_TRIANGLES_ViewController.h"

@interface VertexDrawMode_TRIANGLES_ViewController ()

@end

@implementation VertexDrawMode_TRIANGLES_ViewController

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [super glkView:view drawInRect:rect];
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:VertexNum];
    
}


@end
