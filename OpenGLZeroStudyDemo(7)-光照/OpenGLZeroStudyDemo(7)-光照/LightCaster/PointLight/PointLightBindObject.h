//
//  PointLightBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/7.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    PL_BindAttribLocationBegin = BaseBindLocationEnd,
    PL_BindAttribLocationTexture,
    PL_BindAttribLocationNormal
}PL_BindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector2 texture;
        GLKVector3 normal;
    };
    float t[8];
}PL_BindAttrib;

typedef union{
    struct {
        GLKVector3 position;
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
        float constant;
        float linear;
        float quadratic;
    };
    float m[15];
}PL_Light;

typedef struct{
    int diffuse;
    int specular;
    float shininess;
}PL_Material;



typedef enum {
    PL_UniformLocationBegin = BaseUniformLocationEnd,
    PL_UniformLocationModel,
    PL_UniformLocationInvermodel,
    PL_UniformLocationviewPos,
    PL_UniformLocationLightPos, //
    PL_UniformLocationLightAmbient, //材质
    PL_UniformLocationLightTDiffuse,
    PL_UniformLocationLightSpecular,
    PL_UniformLocationLightConstant,
    PL_UniformLocationLightLinear,
    PL_UniformLocationLightQuadratic,
    PL_UniformLocationMaterialTextureDiffuse,
    PL_UniformLocationMaterialTextureSpecular,
    PL_UniformLocationMaterialTextureShininess
}PL_SpecluarLightTextureUniformLocation;

@interface PointLightBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
