//
//  FlashlightBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/7.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    FL_BindAttribLocationBegin = BaseBindLocationEnd,
    FL_BindAttribLocationTexture,
    FL_BindAttribLocationNormal
}FL_BindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector2 texture;
        GLKVector3 normal;
    };
    float t[8];
}FL_BindAttrib;

typedef union{
    struct {
        GLKVector3 position;
        GLKVector3 direction;
        float cutOff;
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
        float constant;
        float linear;
        float quadratic;
        
        
    };
    float m[19];
}FL_Light;

typedef struct{
    int diffuse;
    int specular;
    float shininess;
}FL_Material;



typedef enum {
    FL_UniformLocationBegin = BaseUniformLocationEnd,
    FL_UniformLocationModel,
    FL_UniformLocationInvermodel,
    FL_UniformLocationviewPos,
    FL_UniformLocationLightPos, //
    FL_UniformLocationLightDirection,
    FL_UniformLocationLightCutOff,
    FL_UniformLocationLightAmbient, //材质
    FL_UniformLocationLightTDiffuse,
    FL_UniformLocationLightSpecular,
    FL_UniformLocationLightConstant,
    FL_UniformLocationLightLinear,
    FL_UniformLocationLightQuadratic,
    FL_UniformLocationMaterialTextureDiffuse,
    FL_UniformLocationMaterialTextureSpecular,
    FL_UniformLocationMaterialTextureShininess
}FL_SpecluarLightTextureUniformLocation;

@interface FlashlightBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
