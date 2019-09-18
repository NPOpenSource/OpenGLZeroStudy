//
//  PhoneLightingBindObject.h
//  OpenGLZeroStudyDemo(17)-高级光照之高级光照
//
//  Created by glodon on 2019/9/18.
//  Copyright © 2019 persion. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    PL_aPos,
    //    aNormal,
    PL_aNormal,
    PL_aTexCoords
} PL_BaseBindAttribLocation;

typedef union {
    struct{
        GLKVector3 PL_aPos;
        GLKVector3 PL_aNormal;
        GLKVector2 PL_aTexCoords;
    };
    float a[8];
}PL_BindAtt;
typedef enum {
    PL_uniform_projection,
    PL_uniform_view,
    PL_uniform_floorTexture,
    PL_uniform_lightPos,
    PL_uniform_viewPos,
    PL_uniform_blinn
} PL_UniformLocation;
@interface PhoneLightingBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END

