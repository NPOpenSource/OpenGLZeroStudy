//
//  MoreLightSourceBindObject.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/8.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    MLS_BindAttribLocationBegin = BaseBindLocationEnd,
    MLS_BindAttribLocationTexture,
    MLS_BindAttribLocationNormal
}MLS_BindAttribLocation;

typedef union {
    struct {
        BaseBindAttribType baseBindAttrib;
        GLKVector2 texture;
        GLKVector3 normal;
    };
    float t[8];
}MLS_BindAttrib;

typedef struct  {
    GLKVector3 direction;
    
    GLKVector3 ambient;
    GLKVector3 diffuse;
    GLKVector3 specular;
}MLS_DirLight;

typedef struct  {
    GLKVector3 position;
    
    float constant;
    float linear;
    float quadratic;
    
    GLKVector3 ambient;
    GLKVector3 diffuse;
    GLKVector3 specular;
}MLS_PointLight;

typedef struct  {
    GLKVector3 position;
    GLKVector3 direction;
    float cutOff;
    float outerCutOff;
    
    float constant;
    float linear;
    float quadratic;
    
    GLKVector3 ambient;
    GLKVector3 diffuse;
    GLKVector3 specular;
}MLS_SpotLight;

typedef struct{
    int diffuse;
    int specular;
    float shininess;
}MLS_Material;



typedef enum {
    MLS_UniformLocationBegin = BaseUniformLocationEnd,
    MLS_UniformLocationModel,
    MLS_UniformLocationInvermodel,
    MLS_UniformLocationviewPos,
    //材质
    MLS_UniformLocationMaterialTextureSpecular,
    MLS_UniformLocationMaterialTextureDiffuse,
    MLS_UniformLocationMaterialTextureshininess,
///平行光
    MLS_UniformLocationDirLightDirection,
    MLS_UniformLocationDirLightAmbient, //材质
    MLS_UniformLocationDirLightDiffuse,
    MLS_UniformLocationDirLightSpecular,
//点光源 0
    MLS_UniformLocationPointLightZeroPos,
    MLS_UniformLocationPointLightZeroAmbient, //材质
    MLS_UniformLocationPointLightZeroDiffuse,
    MLS_UniformLocationPointLightZeroSpecular,
    MLS_UniformLocationPointLightZeroConstant,
    MLS_UniformLocationPointLightZeroLinear,
    MLS_UniformLocationPointLightZeroQuadratic,
 //点光源 1
    MLS_UniformLocationPointLightOnePos,
    MLS_UniformLocationPointLightOneAmbient, //材质
    MLS_UniformLocationPointLightOneDiffuse,
    MLS_UniformLocationPointLightOneSpecular,
    MLS_UniformLocationPointLightOneConstant,
    MLS_UniformLocationPointLightOneLinear,
    MLS_UniformLocationPointLightOneQuadratic,
//点光源 2
    MLS_UniformLocationPointLightTwoPos,
    MLS_UniformLocationPointLightTwoAmbient, //材质
    MLS_UniformLocationPointLightTwoDiffuse,
    MLS_UniformLocationPointLightTwoSpecular,
    MLS_UniformLocationPointLightTwoConstant,
    MLS_UniformLocationPointLightTwoLinear,
    MLS_UniformLocationPointLightTwoQuadratic,
 //点光源 3
    MLS_UniformLocationPointLightThreePos,
    MLS_UniformLocationPointLightThreeAmbient, //材质
    MLS_UniformLocationPointLightThreeDiffuse,
    MLS_UniformLocationPointLightThreeSpecular,
    MLS_UniformLocationPointLightThreeConstant,
    MLS_UniformLocationPointLightThreeLinear,
    MLS_UniformLocationPointLightThreeQuadratic,
    //聚光
    MLS_UniformLocationSpotLightPos,
    MLS_UniformLocationSpotLightDirection,
    MLS_UniformLocationSpotLightAmbient, //材质
    MLS_UniformLocationSpotLightDiffuse,
    MLS_UniformLocationSpotLightSpecular,
    MLS_UniformLocationSpotLightConstant,
    MLS_UniformLocationSpotLightLinear,
    MLS_UniformLocationSpotLightQuadratic,
    MLS_UniformLocationSpotLightcutOff,
    MLS_UniformLocationSpotLightouterCutOff
}MLS_UniformLocation;

@interface MoreLightSourceBindObject : GLBaseBindObject

@end

NS_ASSUME_NONNULL_END
