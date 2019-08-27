//
//  FaceCullingOutOrderViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "FaceCullingOutOrderViewController.h"

@interface FaceCullingOutOrderViewController ()

@end

@implementation FaceCullingOutOrderViewController

-(void)initSubObject{
    [super initSubObject];
   glEnable(GL_CULL_FACE);
    glCullFace(GL_FRONT);
   
}




@end
