//
//  GLMaterialBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
   MaterialBindAttribLocationBegin = BaseBindLocationEnd,
   MaterialBindAttribLocationVertexColor,
   MaterialBindAttribLocationNormal
} MaterialBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 vertextColor;
    };
    float t[6];
}MaterialBindAttrib;

typedef union{
    struct {
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
        float shininess;
    };
    float m[10];
}Material;



typedef enum {
   MaterialUniformLocationBegin = BaseUniformLocationEnd,
   MaterialUniformLocationModel,
   MaterialUniformLocationInvermodel,
   MaterialUniformLocationDiffusePositon,  //光源位置
   MaterialUniformLocationDiffuseLightColor , //光源颜色
   MaterialUniformLocationviewPos,
   MaterialUniformLocationMaterialAmbient, //材质
    MaterialUniformLocationMaterialDiffuse,
    MaterialUniformLocationMaterialsSpecular,
    MaterialUniformLocationMaterialShininess
} MaterialUniformLocation;

@interface GLMaterialBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
