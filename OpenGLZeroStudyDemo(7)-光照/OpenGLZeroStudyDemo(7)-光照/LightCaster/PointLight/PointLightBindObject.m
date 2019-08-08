//
//  PointLightBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/7.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "PointLightBindObject.h"

@implementation PointLightBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
    glBindAttribLocation(program, PL_BindAttribLocationNormal, "a_normal");
    glBindAttribLocation(program, PL_BindAttribLocationTexture, "a_texture");
}

-(NSString *)getShaderName{
    return @"PointLight";
}
@end
