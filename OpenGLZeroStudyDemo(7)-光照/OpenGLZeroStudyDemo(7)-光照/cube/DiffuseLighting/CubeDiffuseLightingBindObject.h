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
     CubeDiffuseLightingBindAttribLocationBegin = BaseBindLocationEnd,
     CubeDiffuseLightingBindAttribLocationVertexColor,
    CubeDiffuseLightingBindAttribLocationNormal
}  CubeDiffuseLightingBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 vertextColor;
    };
    float t[6];
} CubeDiffuseLightingBindAttrib;

typedef enum {
    CubeDiffuseLightingUniformLocationBegin = BaseUniformLocationEnd,
    CubeDiffuseLightingUniformLocationModel,
    CubeDiffuseLightingUniformLocationInvermodel,
    CubeDiffuseLightingUniformLocationDiffusePositon,  //光源位置
    CubeDiffuseLightingUniformLocationDiffuseLightColor , //光源颜色
}  CubeDiffuseLightingUniformLocation;

@interface CubeDiffuseLightingBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
