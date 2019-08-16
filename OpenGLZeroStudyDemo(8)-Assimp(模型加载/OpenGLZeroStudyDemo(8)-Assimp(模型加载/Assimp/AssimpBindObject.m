//
//  AssimpBindObject.m
//  OpenGLZeroStudyDemo(8)-Assimp(模型加载
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "AssimpBindObject.h"

@implementation AssimpBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, aPos, "aPos");
    glBindAttribLocation(program, aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[uniform_diffuse] = glGetUniformLocation(program, "texture_diffuse");
    self->uniforms[uniform_specular] = glGetUniformLocation(program, "texture_specular");
    self->uniforms[uniform_height] = glGetUniformLocation(program, "texture_height");
}

-(NSString *)getShaderName{
    return @"Assimp";
}
@end
