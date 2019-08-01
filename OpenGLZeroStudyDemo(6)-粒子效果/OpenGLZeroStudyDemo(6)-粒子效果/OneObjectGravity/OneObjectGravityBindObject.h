//
//  OneObjectGravityBindObject.h
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    
    OneObjectGravityBindAttribLocationBegin = BaseBindLocationEnd,
    OneObjectGravityBindAttribLocationBeginVelocity,
} OneObjectGravityBindAttribLocation;


typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 beginVelocity;
    };
    float t[7];
}OneObjectGravityBindAttrib;

typedef enum {
    OOneObjectGravityUniformLocationBegin = BaseUniformLocationEnd,
    OneObjectGravityUniformLocationTimeInterval,
    OneObjectGravityUniformLocationGravity,
} OneObjectGravityUniformLocation;

@interface OneObjectGravityBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
