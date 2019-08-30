//
//  FrameBufferBindObject.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
// Attribute identifiers
typedef enum {
    FB_aPos,
    //    aNormal,
    FB_aTexCoords,
} FB_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}FB_BindAtt;

typedef enum {
     FB_uniform_Texture
} FB_UniformLocation;

@interface FrameBufferBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
