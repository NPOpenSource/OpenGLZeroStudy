//
//  OneObjectEdgeCheck.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/30.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "OneObjectEdgeCheck.h"

@implementation OneObjectEdgeCheck
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, OneObjectEdgeCheckBindAttribLocationBeginVelocity, "beginVelocity");
    [super BindAttribLocation:program];
}
-(NSString *)getShaderName{
    return @"Shader4";
}
@end
