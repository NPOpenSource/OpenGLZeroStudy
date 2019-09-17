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
    DF_aColor,
} DF_BaseBindAttribLocation;

typedef union {
    struct{
        GLKVector2 DF_aPos;
        //        GLKVector3 aNormal;
        GLKVector3 DF_aColor;
    };
    float a[5];
}DF_BindAtt;
typedef enum {
    DF_uniform_Offset,

} DF_UniformLocation;
@interface DefaultBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
