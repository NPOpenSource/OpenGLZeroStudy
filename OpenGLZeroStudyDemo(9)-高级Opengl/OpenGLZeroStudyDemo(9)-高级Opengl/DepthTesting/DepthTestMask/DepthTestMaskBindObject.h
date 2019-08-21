//
//  DepthTestMaskBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/19.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    DTM_aPos,
    DTM_aTexture,
} DTM_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexture;
    };
    float a[5];
}DTM_BindAtt;

typedef enum {
    DTM_uniform_model,
    DTM_uniform_view,
    DTM_uniform_projection,
    DTM_uniform_sam2D,
} DTM_UniformLocation;
@interface DepthTestMaskBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
