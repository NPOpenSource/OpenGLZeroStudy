//
//  CubeMixBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "CubeMixBindObject.h"

@implementation CubeMixBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");

    glBindAttribLocation(program, CubeMixBindAttribLocationVertexColor, "vertexColor");
    glBindAttribLocation(program, CubeMixBindAttribLocationNormal, "aNormal");
}

-(NSString *)getShaderName{
    return @"CubeMix";
}
@end
