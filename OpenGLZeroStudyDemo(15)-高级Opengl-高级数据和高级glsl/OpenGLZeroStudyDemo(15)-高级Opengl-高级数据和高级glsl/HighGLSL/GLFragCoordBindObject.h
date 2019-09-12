//
//  GLFragCoordBindObject.h
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    FC_aPos,

} FC_BaseBindAttribLocation;


typedef union {
    struct{
        GLKVector3 aPos;

    };
    float a[3];
}FC_BindAtt;

typedef enum {
    FC_uniform_model,
    FC_uniform_view,
    FC_uniform_projection,
    FC_uniform_screenWidth
} FC_UniformLocation;
@interface GLFragCoordBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
