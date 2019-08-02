//
//  DiffuseLightingBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DiffuseLightingBindObject.h"

@implementation DiffuseLightingBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, DiffuseLightingBindAttribLocationTexture, "texture");
    glBindAttribLocation(program, DiffuseLightingBindAttribLocationNormal, "aNormal");
    
}

-(NSString *)getShaderName{
    return @"Shader1";
}

@end
