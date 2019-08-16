//
//  AssimpParse.m
//  OpenGLZeroStudyDemo(8)-Assimp(模型加载
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "AssimpParse.h"
#include <assimp/Importer.hpp>
#include <assimp/scene.h>
#include <assimp/postprocess.h>
#import "Mesh.h"
#import "MeshVertex.h"
#import "OpenGLUtilsHeader.h"
#import "AssimpTextureUnit.h"

@interface AssimpParse()
@property (nonatomic ,strong) NSString * path ;
@property (nonatomic ,assign)const  aiScene *scene ;
@property (nonatomic ,strong) NSMutableArray * meshs ;
@end


@implementation AssimpParse

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.meshs = [NSMutableArray array];
    }
    return self;
}

-(void)draw:(AssimpBindObject * )bindObject{
    for (Mesh * mesh in self.meshs) {
        [mesh draw:bindObject];
    }
}

-(void)parse{
    Assimp::Importer importer;
    NSString * pathStr = [[NSBundle mainBundle]pathForResource:@"nanosuit" ofType:@"obj"];
    const char *path = pathStr.UTF8String;
    const aiScene *scene = importer.ReadFile(path, aiProcess_Triangulate | aiProcess_FlipUVs);
    if(!scene || scene->mFlags & AI_SCENE_FLAGS_INCOMPLETE || !scene->mRootNode) // if is Not Zero
    {
        NSLog(@"ERROR::ASSIMP: %s",importer.GetErrorString());
        return;
    }
    
    NSString * directory =[pathStr stringByDeletingLastPathComponent];
    NSLog(@"%@",directory);
    self.path = directory;
    self.scene = scene;
    [self processNode:scene->mRootNode];
}

-(void)processNode:(aiNode *)node{
    for(unsigned int i = 0; i < node->mNumMeshes; i++)
    {
        aiMesh *mesh = self.scene->mMeshes[node->mMeshes[i]];
        Mesh * meshObj =[self processMesh:mesh];
        [meshObj parse];
        [self.meshs addObject:meshObj];
    }
    // 接下来对它的子节点重复这一过程
    for(unsigned int i = 0; i < node->mNumChildren; i++)
    {
        [self processNode:node->mChildren[i]];
    }
}
-(Mesh*) processMesh:(aiMesh *)mesh{
    Mesh * meshObj= [Mesh new];
    for(unsigned int i = 0; i < mesh->mNumVertices; i++)
    {
        MeshVertex * vertex = [MeshVertex new];
        GLKVector3  vector;
        // positions
        vector.x = mesh->mVertices[i].x;
        vector.y = mesh->mVertices[i].y;
        vector.z = mesh->mVertices[i].z;
        vertex.Position = vector;

        // texture coordinates
        if(mesh->mTextureCoords[0]) // does the mesh contain texture coordinates?
        {
            GLKVector2 vec;
            vec.x = mesh->mTextureCoords[0][i].x;
            vec.y = mesh->mTextureCoords[0][i].y;
            vertex.TexCoords = vec;
        }
        else
            vertex.TexCoords = GLKVector2Make(0.0f, 0.0f);
        [meshObj.vertices  addObject:vertex];
    }
    
    for(unsigned int i = 0; i < mesh->mNumFaces; i++)
    {
        aiFace face = mesh->mFaces[i];
        // retrieve all indices of the face and store them in the indices vector
        for(unsigned int j = 0; j < face.mNumIndices; j++)
            [meshObj.indices addObject:@(face.mIndices[j])];
    }
    aiMaterial* material = self.scene->mMaterials[mesh->mMaterialIndex];
    //   1. diffuse maps
    NSMutableArray * diffuse =[self loadMaterialTextures:material type:aiTextureType_DIFFUSE typeName:@"texture_diffuse"];
    [meshObj.textures addObjectsFromArray:diffuse];
    // 2. specular maps
    NSMutableArray *  specularMaps = [self loadMaterialTextures:material type:aiTextureType_SPECULAR typeName:@"texture_specular"];
    [meshObj.textures addObjectsFromArray:specularMaps];

    // 4. height maps
    NSMutableArray * heightMaps = [self loadMaterialTextures:material type:aiTextureType_AMBIENT typeName:@"texture_height"];
    [meshObj.textures addObjectsFromArray:heightMaps];
//
    return meshObj;
}
-(NSMutableArray*) loadMaterialTextures:(aiMaterial *)mat type:(aiTextureType) type typeName:(NSString *) typeName{
    NSMutableArray * textures =  [NSMutableArray new];
    for(unsigned int i = 0; i < mat->GetTextureCount(type); i++)
    {
        aiString str;
        mat->GetTexture(type, i, &str);
        NSString * filename =[NSString stringWithFormat:@"%@/%s",self.path,str.C_Str()];
        UIImage * image = [UIImage imageWithContentsOfFile:filename];
        AssimpTextureUnit * unit = [AssimpTextureUnit new];
        unit.typeName = typeName;
        [unit setImage:image andConfigTextureUnit:nil];
        [textures addObject:unit];
    }
    return textures;
}
@end
