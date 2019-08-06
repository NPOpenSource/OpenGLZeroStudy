//
//  GLLightBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLLightBindObject.h"

@implementation GLLightBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
    glBindAttribLocation(program,LightBindAttribLocationNormal, "aNormal");
}

-(NSString *)getShaderName{
    return @"light";
}
@end
