//
//  LightBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "LightBindObject.h"

@implementation LightBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, LightBindAttribLocationTexture, "texture");
}

-(NSString *)getShaderName{
    return @"Shader";
}
@end
