//
//  MoreLightSourceBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/8.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "MoreLightSourceBindObject.h"

@implementation MoreLightSourceBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
    glBindAttribLocation(program, MLS_BindAttribLocationNormal, "a_normal");
    glBindAttribLocation(program, MLS_BindAttribLocationTexture, "a_texture");
}

-(NSString *)getShaderName{
    return @"MoreLightSource";
}
@end
