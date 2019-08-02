//
//  DiffuseLightingBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    DiffuseLightingBindAttribLocationBegin = BaseBindLocationEnd,
    DiffuseLightingBindAttribLocationNormal,  //法线
    DiffuseLightingBindAttribLocationTexture,
} DiffuseLightingBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 normal;
        GLKVector2 texture;
    };
    float t[8];
}DiffuseLightingBindAttrib;

typedef enum {
    DiffuseLightingUniformLocationBegin = BaseUniformLocationEnd,
    DiffuseLightingUniformLocationModel,  //mvp中的m
    DiffuseLightingUniformLocationInverModel,
    DiffuseLightingUniformLocationDiffuse,   //漫反射
    DiffuseLightingUniformLocationDiffusePositon,  //光源位置
    DiffuseLightingUniformLocationDiffuseLightColor , //光源颜色
    DiffuseLightingUniformLocationAmbientLight,  ///自然光
} DiffuseLightingUniformLocation;

@interface DiffuseLightingBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
