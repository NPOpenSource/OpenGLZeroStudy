//
//  FlashlightBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/7.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "FlashlightBindObject.h"

@implementation FlashlightBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
    glBindAttribLocation(program, FL_BindAttribLocationNormal, "a_normal");
    glBindAttribLocation(program, FL_BindAttribLocationTexture, "a_texture");
}

-(NSString *)getShaderName{
    return @"Flashlight";
}
@end
