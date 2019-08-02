//
//  CubeMixBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    CubeMixBindAttribLocationBegin = BaseBindLocationEnd,
    CubeMixBindAttribLocationVertexColor,
    CubeMixBindAttribLocationNormal
}  CubeMixBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 vertextColor;
    };
    float t[6];
} CubeMixBindAttrib;

typedef enum {
    CubeMixUniformLocationBegin = BaseUniformLocationEnd,
    CubeMixUniformLocationModel,
    CubeMixUniformLocationInvermodel,
    CubeMixUniformLocationDiffusePositon,  //光源位置
    CubeMixUniformLocationDiffuseLightColor , //光源颜色
    CubeMixUniformLocationviewPos,
    CubeMixUniformLocationAmbientLight //自然光
}  CubeMixUniformLocation;

@interface CubeMixBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
