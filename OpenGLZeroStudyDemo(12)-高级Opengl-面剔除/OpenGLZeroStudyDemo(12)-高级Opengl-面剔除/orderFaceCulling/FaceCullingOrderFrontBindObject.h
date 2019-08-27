//
//  FaceCullingOrderFrontBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    FCOF_aPos,
    //    aNormal,
    FCOF_aTexCoords,
} FCOF_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}FCOF_BindAtt;

typedef enum {
    FCOF_uniform_model,
    FCOF_uniform_view,
    FCOF_uniform_projection,
     FCOF_uniform_Texture
} FCOF_UniformLocation;

@interface FaceCullingOrderFrontBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
