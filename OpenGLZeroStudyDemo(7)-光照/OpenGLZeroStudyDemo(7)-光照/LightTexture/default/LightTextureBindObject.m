//
//  LightTextureBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "LightTextureBindObject.h"

@implementation LightTextureBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
    glBindAttribLocation(program, LightTextureBindAttribLocationNormal, "a_normal");
    glBindAttribLocation(program, LightTextureBindAttribLocationTexture, "a_texture");

}

-(NSString *)getShaderName{
    return @"LightTexture";
}
@end
