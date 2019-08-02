//
//  CubeAmibentLightBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "CubeAmibentLightBindObject.h"

@implementation CubeAmibentLightBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, CubeAmibentLightBindAttribLocationVertexColor, "vertexColor");
}

-(NSString *)getShaderName{
    return @"CubeAmibentLight";
}
@end
