//
//  ShadowDepthBindObject.h
//  OpenGLZeroStudyDemo(18)-高级光照之阴影
//
//  Created by glodon on 2019/10/17.
//  Copyright © 2019 persion. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    SDD_aPos,
} SDD_BaseBindAttribLocation;

typedef union {
    struct{
        GLKVector3 SDD_aPos;
    };
    float a[3];
}SDD_BindAtt;
typedef enum {
    SDD_uniform_lightSpaceMatrix,
    SDD_uniform_model,
} SDD_UniformLocation;
@interface ShadowDepthBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
