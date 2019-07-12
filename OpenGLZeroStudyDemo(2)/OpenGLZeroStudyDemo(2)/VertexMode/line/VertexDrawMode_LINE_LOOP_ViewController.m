//
//  VertexDrawMode_LINE_LOOP_ViewController.m
//  OpenGLZeroStudyDemo(2)
//
//  Created by glodon on 2019/7/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "VertexDrawMode_LINE_LOOP_ViewController.h"

@interface VertexDrawMode_LINE_LOOP_ViewController ()

@end

@implementation VertexDrawMode_LINE_LOOP_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [super glkView:view drawInRect:rect];
    [self.vertex drawVertexWithMode:GL_LINE_LOOP startVertexIndex:0 numberOfVertices:VertexNum];
    
}

@end
