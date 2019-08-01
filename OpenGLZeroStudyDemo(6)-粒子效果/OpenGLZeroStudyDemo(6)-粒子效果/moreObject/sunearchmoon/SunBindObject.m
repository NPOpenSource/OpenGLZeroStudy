//
//  SunBindObject.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/31.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "SunBindObject.h"

@implementation SunBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, WorldStartPosition, "beginPostion");
    glBindAttribLocation(program, WorldTexture, "texture");
}

-(NSString *)getShaderName{
    return @"Shader6";
}
@end
