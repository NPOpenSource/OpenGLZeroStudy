//
//  LightTextureTextureBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    LightTextureBindAttribLocationBegin = BaseBindLocationEnd,
    LightTextureBindAttribLocationTexture,
    LightTextureBindAttribLocationNormal
}LightTextureBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector2 texture;
        GLKVector3 normal;
    };
    float t[8];
}LightTextureBindAttrib;



typedef enum {
    LightTextureUniformLocationBegin = BaseUniformLocationEnd,
    LightTextureUniformLocationModel,
    LightTextureUniformLocationInvermodel,
    LightTextureUniformLocationviewPos,
}LightTextureUniformLocation;

@interface LightTextureBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
