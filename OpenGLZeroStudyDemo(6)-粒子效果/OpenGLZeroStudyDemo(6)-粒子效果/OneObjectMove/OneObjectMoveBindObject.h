//
//  OneObjectMoveBindObject.h
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    
   OneObjectMoveBindAttribLocationBegin = BaseBindLocationEnd,
    OneObjectMoveBindAttribLocationBeginVelocity,
} OneObjectMoveBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 beginVelocity;
    };
    float t[7];
}OneObjectMoveBindAttrib;


typedef enum {
    OneObjectMoveUniformLocationBegin = BaseUniformLocationEnd,
     OneObjectMoveUniformLocationTimeInterval,
} OneObjectMoveUniformLocation;

@interface OneObjectMoveBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
