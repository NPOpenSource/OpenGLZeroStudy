//
//  DefaultRenderBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    DR_aPos,
    //    aNormal,
    DR_aTexCoords,
} DR_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}DR_BindAtt;

typedef enum {
    DR_uniform_model,
    DR_uniform_view,
    DR_uniform_projection,
     DR_uniform_Texture
} DR_UniformLocation;

@interface DefaultRenderBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
