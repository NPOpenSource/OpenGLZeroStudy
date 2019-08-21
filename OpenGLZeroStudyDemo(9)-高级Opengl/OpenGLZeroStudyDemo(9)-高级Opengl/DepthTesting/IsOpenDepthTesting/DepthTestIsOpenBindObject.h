//
//  DepthTestIsOpenBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    DTIO_aPos,
    DTIO_aColor,
} DTIO_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector3 aColor;
    };
    float a[6];
}DTIO_BindAtt;

typedef enum {
    DTIO_uniform_model,
    DTIO_uniform_view,
    DTIO_uniform_projection,
} DTIO_UniformLocation;
@interface DepthTestIsOpenBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
