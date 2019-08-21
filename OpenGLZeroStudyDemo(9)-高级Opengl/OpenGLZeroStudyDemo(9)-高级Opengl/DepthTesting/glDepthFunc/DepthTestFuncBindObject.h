//
//  DepthTestFuncBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/20.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    DTF_aPos,
    DTF_aTexture,
} DTF_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexture;
    };
    float a[5];
}DTF_BindAtt;

typedef enum {
    DTF_uniform_model,
    DTF_uniform_view,
    DTF_uniform_projection,
    DTF_uniform_sam2D,
} DTF_UniformLocation;
@interface DepthTestFuncBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
