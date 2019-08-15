//
//  FlashlightSmoothBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/7.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    FLM_BindAttribLocationBegin = BaseBindLocationEnd,
    FLM_BindAttribLocationTexture,
    FLM_BindAttribLocationNormal
}FLM_BindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector2 texture;
        GLKVector3 normal;
    };
    float t[8];
}FLM_BindAttrib;

typedef union{
    struct {
        GLKVector3 position;
        GLKVector3 direction;
        float cutOff;
         float outcutOff;
        
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
        float constant;
        float linear;
        float quadratic;
    };
    float m[20];
}FLM_Light;

typedef struct{
    int diffuse;
    int specular;
    float shininess;
}FLM_Material;



typedef enum {
    FLM_UniformLocationBegin = BaseUniformLocationEnd,
    FLM_UniformLocationModel,
    FLM_UniformLocationInvermodel,
    FLM_UniformLocationviewPos,
    FLM_UniformLocationLightPos, //
    FLM_UniformLocationLightDirection,
    FLM_UniformLocationLightCutOff,
    FLM_UniformLocationLightOutCutOff,
    FLM_UniformLocationLightAmbient, //材质
    FLM_UniformLocationLightTDiffuse,
    FLM_UniformLocationLightSpecular,
    FLM_UniformLocationLightConstant,
    FLM_UniformLocationLightLinear,
    FLM_UniformLocationLightQuadratic,
    FLM_UniformLocationMaterialTextureDiffuse,
    FLM_UniformLocationMaterialTextureSpecular,
    FLM_UniformLocationMaterialTextureShininess
}FLM_SpecluarLightTextureUniformLocation;

@interface FlashlightSmoothBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
