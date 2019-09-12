//
//  GLPointBindObject.h
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    PT_aPos,
} DF_BaseBindAttribLocation;
typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
    };
    float a[3];
}DF_BindAtt;

typedef enum {
    PT_uniform_MVPMatrix,
} DF_UniformLocation;
@interface GLPointBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
