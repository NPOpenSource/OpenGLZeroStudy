//
//  DiffuseDiffuseLightTextureBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    DiffuseLightTextureBindAttribLocationBegin = BaseBindLocationEnd,
    DiffuseLightTextureBindAttribLocationTexture,
    DiffuseLightTextureBindAttribLocationNormal
}DiffuseLightTextureBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector2 texture;
        GLKVector3 normal;
    };
    float t[8];
}DiffuseLightTextureBindAttrib;

typedef union{
    struct {
        GLKVector3 lightPos;
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
    };
    float m[12];
}DLTLight;

typedef struct{
        int diffuse;
        GLKVector3 specular;
        float shininess;
}DLTMaterial;



typedef enum {
    DiffuseLightTextureUniformLocationBegin = BaseUniformLocationEnd,
    DiffuseLightTextureUniformLocationModel,
    DiffuseLightTextureUniformLocationInvermodel,
    DiffuseLightTextureUniformLocationviewPos,
    DiffuseLightTextureUniformLocationDiffuseLightTexturePos, //
    DiffuseLightTextureUniformLocationDiffuseLightTextureAmbient, //材质
    DiffuseLightTextureUniformLocationDiffuseLightTextureDiffuse,
    DiffuseLightTextureUniformLocationDiffuseLightTexturesSpecular,
    MaterialTextureUniformLocationMaterialTextureDiffuse,
    MaterialTextureUniformLocationMaterialTextureSpecular,
    MaterialTextureUniformLocationMaterialTextureShininess
}DiffuseLightTextureUniformLocation;

@interface DiffuseLightTextureBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
