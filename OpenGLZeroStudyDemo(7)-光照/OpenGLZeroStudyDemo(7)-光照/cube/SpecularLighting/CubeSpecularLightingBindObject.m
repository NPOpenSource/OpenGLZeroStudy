//
//  CubeSpecularLightingBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "CubeSpecularLightingBindObject.h"

@implementation CubeSpecularLightingBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, CubeSpecularLightingBindAttribLocationVertexColor, "vertexColor");
    glBindAttribLocation(program, CubeSpecularLightingBindAttribLocationNormal, "aNormal");
}

-(NSString *)getShaderName{
    return @"CubeSpecularLighting";
}
@end
