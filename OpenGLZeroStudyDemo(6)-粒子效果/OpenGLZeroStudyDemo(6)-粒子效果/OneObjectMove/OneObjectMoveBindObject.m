//
//  OneObjectMoveBindObject.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "OneObjectMoveBindObject.h"

@implementation OneObjectMoveBindObject
-(void)BindAttribLocation:(GLuint)program{
     glBindAttribLocation(program, OneObjectMoveBindAttribLocationBeginVelocity, "beginVelocity");
    [super BindAttribLocation:program];
}
-(NSString *)getShaderName{
    return @"Shader2";
}
@end
