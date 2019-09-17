//
//  DivisorBindObject.h
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    DV_aPos,
    //    aNormal,
    DV_aColor,
    DV_aOffset,
} DV_BaseBindAttribLocation;

typedef union {
    struct{
        GLKVector2 DV_aPos;
        //        GLKVector3 aNormal;
        GLKVector3 DV_aColor;
        GLKVector2 DV_aOffset;

    };
    float a[7];
}DV_BindAtt;
typedef enum {
    DV_uniform_Offset,

} DV_UniformLocation;
@interface DivisorBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
