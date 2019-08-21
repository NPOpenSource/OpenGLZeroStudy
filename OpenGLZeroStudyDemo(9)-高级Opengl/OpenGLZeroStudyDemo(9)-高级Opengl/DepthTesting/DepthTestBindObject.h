//
//  DepthTestBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    DT_aPos,
    //    aNormal,
    DT_aTexCoords,
} DT_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}DT_BindAtt;

typedef enum {
    DT_uniform_model,
    DT_uniform_view,
    DT_uniform_projection,
     DT_uniform_Texture
} DT_UniformLocation;

@interface DepthTestBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
