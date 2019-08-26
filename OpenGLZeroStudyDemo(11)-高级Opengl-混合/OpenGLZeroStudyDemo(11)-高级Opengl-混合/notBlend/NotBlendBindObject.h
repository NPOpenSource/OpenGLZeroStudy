//
//  NotBlendBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    NST_aPos,
    //    aNormal,
    NST_aTexCoords,
} NST_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}NST_BindAtt;

typedef enum {
    NST_uniform_model,
    NST_uniform_view,
    NST_uniform_projection,
     NST_uniform_Texture
} NST_UniformLocation;

@interface NotBlendBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
