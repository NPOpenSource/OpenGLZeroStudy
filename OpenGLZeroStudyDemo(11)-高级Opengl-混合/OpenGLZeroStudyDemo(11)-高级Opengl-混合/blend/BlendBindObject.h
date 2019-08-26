//
//  BlendBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    ST_aPos,
    //    aNormal,
    ST_aTexCoords,
} ST_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}ST_BindAtt;

typedef enum {
    ST_uniform_model,
    ST_uniform_view,
    ST_uniform_projection,
     ST_uniform_Texture
} ST_UniformLocation;

@interface BlendBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
