//
//  Divisor2BindObject.h
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    DV2_aPos,
    //    aNormal,
    DV2_aColor,
    DV2_aOffset,
} DV2_BaseBindAttribLocation;

typedef union {
    struct{
        GLKVector2 DV2_aPos;
        //        GLKVector3 aNormal;
        GLKVector3 DV2_aColor;
        GLKVector2 DV2_aOffset;

    };
    float a[7];
}DV2_BindAtt;
typedef enum {
    DV2_uniform_Offset,

} DV2_UniformLocation;
@interface Divisor2BindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
