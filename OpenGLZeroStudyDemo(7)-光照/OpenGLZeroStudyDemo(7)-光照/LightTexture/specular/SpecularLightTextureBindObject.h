//
//  SpecularLightTextureBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/7.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
   SLT_SpecluarLightTextureBindAttribLocationBegin = BaseBindLocationEnd,
   SLT_SpecluarLightTextureBindAttribLocationTexture,
   SLT_SpecluarLightTextureBindAttribLocationNormal
}SLT_SpecluarLightTextureBindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector2 texture;
        GLKVector3 normal;
    };
    float t[8];
}SLT_SpecluarLightTextureBindAttrib;

typedef union{
    struct {
        GLKVector3 lightPos;
        GLKVector3 ambient;
        GLKVector3 diffuse;
        GLKVector3 specular;
    };
    float m[12];
}SLT_Light;

typedef struct{
    int diffuse;
    int specular;
    float shininess;
}SLT_Material;



typedef enum {
   SLT_SpecluarLightTextureUniformLocationBegin = BaseUniformLocationEnd,
   SLT_SpecluarLightTextureUniformLocationModel,
   SLT_SpecluarLightTextureUniformLocationInvermodel,
   SLT_SpecluarLightTextureUniformLocationviewPos,
   SLT_SpecluarLightTextureUniformLocationSpecluarLightTexturePos, //
   SLT_SpecluarLightTextureUniformLocationSpecluarLightTextureAmbient, //材质
   SLT_SpecluarLightTextureUniformLocationSpecluarLightTextureDiffuse,
   SLT_SpecluarLightTextureUniformLocationSpecluarLightTexturesSpecular,
   SLT_MaterialTextureUniformLocationMaterialTextureDiffuse,
   SLT_MaterialTextureUniformLocationMaterialTextureSpecular,
   SLT_MaterialTextureUniformLocationMaterialTextureShininess
}SLT_SpecluarLightTextureUniformLocation;

@interface SpecularLightTextureBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
