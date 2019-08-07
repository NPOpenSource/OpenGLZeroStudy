//
//  SpecularLightTextureBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/7.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "SpecularLightTextureBindObject.h"

@implementation SpecularLightTextureBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
    glBindAttribLocation(program, SLT_SpecluarLightTextureBindAttribLocationNormal, "a_normal");
    glBindAttribLocation(program, SLT_SpecluarLightTextureBindAttribLocationTexture, "a_texture");
}

-(NSString *)getShaderName{
    return @"SpecluarLightTexture";
}
@end
