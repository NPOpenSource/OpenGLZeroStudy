//
//  GLMaterialBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLMaterialBindObject.h"

@implementation GLMaterialBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
    glBindAttribLocation(program,MaterialBindAttribLocationNormal, "aNormal");
}

-(NSString *)getShaderName{
    return @"material";
}
@end
