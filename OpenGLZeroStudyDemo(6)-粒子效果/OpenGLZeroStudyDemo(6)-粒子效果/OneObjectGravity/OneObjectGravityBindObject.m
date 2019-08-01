//
//  OneObjectGravityBindObject.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "OneObjectGravityBindObject.h"

@implementation OneObjectGravityBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, OneObjectGravityBindAttribLocationBeginVelocity, "beginVelocity");
    [super BindAttribLocation:program];
}
-(NSString *)getShaderName{
    return @"Shader3";
}
@end
