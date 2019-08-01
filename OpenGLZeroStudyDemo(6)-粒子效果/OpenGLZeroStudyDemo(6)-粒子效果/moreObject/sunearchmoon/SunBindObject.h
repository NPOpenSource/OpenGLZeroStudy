//
//  SunBindObject.h
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/31.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    WorldStartPosition = 0,
    WorldTexture,
} WorldBindAttribLocation;


typedef union {
    struct{
        GLKVector3 startPosition;
        GLKVector2 texture;
    };
    float t[5];
}WorldBindAttribType;



typedef enum {
    WorldMVPMatrix,
    WorldSample,
} WorldUniformLocation;
@interface SunBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
