//
//  NotAlphaNotBlendBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    NANST_aPos,
    //    aNormal,
    NANST_aTexCoords,
} NANST_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}NANST_BindAtt;

typedef enum {
    NANST_uniform_model,
    NANST_uniform_view,
    NANST_uniform_projection,
     NANST_uniform_Texture
} NANST_UniformLocation;

@interface NotAlphaNotBlendBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
