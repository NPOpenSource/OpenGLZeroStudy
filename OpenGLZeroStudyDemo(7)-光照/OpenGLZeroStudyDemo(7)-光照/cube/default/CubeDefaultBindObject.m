//
//  CubeDefaultBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "CubeDefaultBindObject.h"

@implementation CubeDefaultBindObject
-(void)BindAttribLocation:(GLuint)program{
    [super BindAttribLocation:program];
    glBindAttribLocation(program, CubeDefaulttBindAttribLocationVertexColor, "vertexColor");
}

-(NSString *)getShaderName{
    return @"Cube";
}
@end
