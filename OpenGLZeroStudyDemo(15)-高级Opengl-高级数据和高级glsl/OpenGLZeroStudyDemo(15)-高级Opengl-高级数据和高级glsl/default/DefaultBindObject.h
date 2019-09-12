//
//  DefaultBindObject.h
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    DF_aPos,
    //    aNormal,
    DF_aTexCoords,
} DF_BaseBindAttribLocation;

typedef union {
    struct{
        GLKVector3 aPos;
        //        GLKVector3 aNormal;
        GLKVector2 aTexCoords;
    };
    float a[5];
}DF_BindAtt;
typedef enum {
    DF_uniform_MVPMatrix,
    DF_uniform_Samplers2D,
    DF_uniform_AmbientLight
} DF_UniformLocation;
@interface DefaultBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
