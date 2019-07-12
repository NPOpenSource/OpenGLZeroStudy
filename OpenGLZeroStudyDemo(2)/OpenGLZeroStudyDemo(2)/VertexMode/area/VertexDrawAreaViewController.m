//
//  VertexDrawAreaViewController.m
//  OpenGLZeroStudyDemo(2)
//
//  Created by glodon on 2019/7/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "VertexDrawAreaViewController.h"

@interface VertexDrawAreaViewController ()

@end

@implementation VertexDrawAreaViewController

-(NSArray *)buttonTitles{
    return @[@[@"GL_TRIANGLES",@"VertexDrawMode_TRIANGLES_ViewController"],@[@"GL_TRIANGLE_STRIP",@"VertexDrawMode_TRIANGLE_STRIP_ViewController"],@[@"GL_TRIANGLE_FAN",@"VertexDrawMode_TRIANGLE_FAN_ViewController"]];
}


@end
