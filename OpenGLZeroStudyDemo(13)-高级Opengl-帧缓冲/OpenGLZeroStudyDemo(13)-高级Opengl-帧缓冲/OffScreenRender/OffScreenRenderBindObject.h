//
//  OffScreenRenderBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    OSR_aPos,
    //    aNormal,
    OSR_aTexCoords,
} OSR_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}OSR_BindAtt;

typedef enum {
    OSR_uniform_model,
    OSR_uniform_view,
    OSR_uniform_projection,
     OSR_uniform_Texture
} OSR_UniformLocation;

@interface OffScreenRenderBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
