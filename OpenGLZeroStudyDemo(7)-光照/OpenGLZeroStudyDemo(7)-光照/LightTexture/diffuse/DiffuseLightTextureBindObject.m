//
//  DiffuseLightTextureBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DiffuseLightTextureBindObject.h"

@implementation DiffuseLightTextureBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
    glBindAttribLocation(program, DiffuseLightTextureBindAttribLocationNormal, "a_normal");
    glBindAttribLocation(program, DiffuseLightTextureBindAttribLocationTexture, "a_texture");
}

-(NSString *)getShaderName{
    return @"DiffuseLightTexture";
}
@end
