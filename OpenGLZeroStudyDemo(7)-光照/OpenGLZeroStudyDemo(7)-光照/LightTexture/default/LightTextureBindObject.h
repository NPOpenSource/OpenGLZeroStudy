//
//  LightTextureTextureBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/6.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    LightTextureBindAttribLocationBegin = BaseBindLocationEnd,
    LightTextureBindAttribLocationTexture,
    LightTextureBindAttribLocationNormal
}LightTextureBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector3 texture;
        GLKVector2 normal;
    };
    float t[8];
}LightTextureBindAttrib;

typedef union{
    struct {
        GLKVector3 lightPos;
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
    };
    float m[12];
}LTLight;

typedef union{
    struct {
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
        float shininess;
    };
    float m[10];
}LTMaterial;



typedef enum {
    LightTextureUniformLocationBegin = BaseUniformLocationEnd,
    LightTextureUniformLocationModel,
    LightTextureUniformLocationInvermodel,
    LightTextureUniformLocationviewPos,
    LightTextureUniformLocationLightTexturePos, //
    LightTextureUniformLocationLightTextureAmbient, //材质
    LightTextureUniformLocationLightTextureDiffuse,
    LightTextureUniformLocationLightTexturesSpecular,
    MaterialObjectUniformLocationMaterialAmbient, //材质
    MaterialObjectUniformLocationMaterialDiffuse,
    MaterialObjectUniformLocationMaterialsSpecular,
    MaterialObjectUniformLocationMaterialShininess
}LightTextureUniformLocation;

@interface LightTextureBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
