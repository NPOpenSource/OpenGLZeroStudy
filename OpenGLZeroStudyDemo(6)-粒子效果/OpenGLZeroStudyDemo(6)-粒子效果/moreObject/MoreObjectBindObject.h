//
//  MoreObjectBindObject.h
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/30.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
   MoreObjectBindAttribLocationBegin = BaseBindLocationEnd,
   MoreObjectBindAttribLocationGravity,
    MoreObjectBindAttribLocationLifeTime,
} MoreObjectBindAttribLocation;


typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 gravity;
        float lifeTime;

    };
    float t[8];
}OneObjectEdgeCheckBindAttrib;

typedef enum {
     MoreObjectUniformLocationBegin = BaseUniformLocationEnd,
     MoreObjectUniformLocationBeginTime,
     MoreObjectUniformLocationCurrentTime,
    MoreObjectUniformLocationForce,
     MoreObjectUniformLocationBeginVelocity
} MoreObjectUniformLocation;

@interface MoreObjectBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
