//
//  VertexPointDrawModeController.m
//  OpenGLZeroStudyDemo(2)
//
//  Created by glodon on 2019/7/11.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "VertexPointDrawModeController.h"

@implementation VertexPointDrawModeController
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [super glkView:view drawInRect:rect];
    [self.vertex drawVertexWithMode:GL_POINTS startVertexIndex:0 numberOfVertices:VertexNum];

}

@end
