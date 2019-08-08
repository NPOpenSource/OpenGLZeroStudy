//
//  DirectionLightBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/7.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    DL_BindAttribLocationBegin = BaseBindLocationEnd,
    DL_BindAttribLocationTexture,
    DL_BindAttribLocationNormal
}DL_BindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector2 texture;
        GLKVector3 normal;
    };
    float t[8];
}DL_BindAttrib;

typedef union{
    struct {
        GLKVector3 direct;
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
    };
    float m[12];
}DL_Light;

typedef struct{
    int diffuse;
    int specular;
    float shininess;
}DL_Material;



typedef enum {
    DL_UniformLocationBegin = BaseUniformLocationEnd,
    DL_UniformLocationModel,
    DL_UniformLocationInvermodel,
    DL_UniformLocationviewPos,
    DL_UniformLocationLightDirect, //
    DL_UniformLocationLightAmbient, //材质
    DL_UniformLocationLightTDiffuse,
    DL_UniformLocationLightSpecular,
    DL_UniformLocationMaterialTextureDiffuse,
    DL_UniformLocationMaterialTextureSpecular,
    DL_UniformLocationMaterialTextureShininess
}DL_SpecluarLightTextureUniformLocation;

@interface DirectionLightBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
