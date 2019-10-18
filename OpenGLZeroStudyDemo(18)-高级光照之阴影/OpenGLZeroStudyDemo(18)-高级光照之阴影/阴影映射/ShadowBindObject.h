//
//  ShadowBindObject.h
//  OpenGLZeroStudyDemo(18)-高级光照之阴影
//
//  Created by glodon on 2019/10/17.
//  Copyright © 2019 persion. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    SD_aPos,
    //    aNormal,
    SD_aTexCoords
} SD_BaseBindAttribLocation;

typedef union {
    struct{
        GLKVector3 SD_aPos;
        GLKVector2 SD_aTexCoords;
    };
    float a[5];
}SD_BindAtt;
typedef enum {
    SD_uniform_depthMap,
    SD_uniform_nearPlane,
    SD_uniform_farPlane,
} SD_UniformLocation;
@interface ShadowBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
