//
//  OneObjectBindObject.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "OneObjectBindObject.h"

@implementation OneObjectBindObject
-(void)BindAttribLocation:(GLuint)program{
    [super BindAttribLocation:program];
}
-(NSString *)getShaderName{
    return @"Shader1";
}
@end

