//
//  CubeSpecularLightingBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLBaseBindObject.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum {
    CubeSpecularLightingBindAttribLocationBegin = BaseBindLocationEnd,
    CubeSpecularLightingBindAttribLocationVertexColor,
    CubeSpecularLightingBindAttribLocationNormal
}  CubeSpecularLightingBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 vertextColor;
    };
    float t[6];
} CubeSpecularLightingBindAttrib;

typedef enum {
    CubeSpecularLightingUniformLocationBegin = BaseUniformLocationEnd,
    CubeSpecularLightingUniformLocationModel,
    CubeSpecularLightingUniformLocationInvermodel,
    CubeSpecularLightingUniformLocationDiffusePositon,  //光源位置
    CubeSpecularLightingUniformLocationDiffuseLightColor , //光源颜色
    CubeSpecularLightingUniformLocationviewPos,
}  CubeSpecularLightingUniformLocation;

@interface CubeSpecularLightingBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
