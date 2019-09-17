//
//  InstanceIDBindObject.h
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    IST_aPos,
    //    aNormal,
    IST_aColor,
} IST_BaseBindAttribLocation;

typedef union {
    struct{
        GLKVector2 IST_aPos;
        //        GLKVector3 aNormal;
        GLKVector3 IST_aColor;
    };
    float a[5];
}IST_BindAtt;
typedef enum {
    IST_uniform_Offset,

} IST_UniformLocation;
@interface InstanceIDBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
