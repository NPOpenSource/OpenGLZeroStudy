//
//  OneObjectEdgeCheck.h
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/30.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    
   OneObjectEdgeCheckBindAttribLocationBegin = BaseBindLocationEnd,
   OneObjectEdgeCheckBindAttribLocationBeginVelocity,
} OneObjectEdgeCheckBindAttribLocation;


typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 beginVelocity;
    };
    float t[7];
}OneObjectEdgeCheckBindAttrib;

typedef enum {
    OneObjectEdgeCheckUniformLocationBegin = BaseUniformLocationEnd,
    OneObjectEdgeCheckUniformLocationTimeInterval,
    OneObjectEdgeCheckUniformLocationGravity,
    OneObjectEdgeCheckUniformLocationBeginTime
} OneObjectGravityUniformLocation;

@interface OneObjectEdgeCheck : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
