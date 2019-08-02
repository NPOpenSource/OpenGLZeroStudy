//
//  DiffuseLightingBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "CubeDiffuseLightingBindObject.h"

@implementation CubeDiffuseLightingBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, CubeDiffuseLightingBindAttribLocationVertexColor, "vertexColor");
    glBindAttribLocation(program, CubeDiffuseLightingBindAttribLocationNormal, "aNormal");
}

-(NSString *)getShaderName{
    return @"CubeDiffuseLighting";
}
@end
