//
//  Mesh.m
//  OpenGLZeroStudyDemo(8)-Assimp(模型加载
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "Mesh.h"
#import "OpenGLUtilsHeader.h"
#import "MeshVertex.h"
#import "AssimpTextureUnit.h"
@interface Mesh()
@property (nonatomic ,strong) Vertex * vertex ;
@property (nonatomic ,strong) VertexElement * elementVertex ;
@end

@implementation Mesh
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.vertices =  [NSMutableArray array];
        self.indices = [NSMutableArray array];
        self.textures = [NSMutableArray array];
    }
    return self;
}
-(void)parse{
    self.vertex= [Vertex new];
    int vertexNum =self.vertices.count;
    [self.vertex allocVertexNum:vertexNum andEachVertexNum:5];
    for (int i=0; i<vertexNum; i++) {
        float onevertex[5];
        MeshVertex * meshVertex = self.vertices[i];
        for (int j=0; j<3; j++) {
            onevertex[j]=meshVertex.Position.v[j];
        }
        for (int j=0; j<2; j++) {
            onevertex[j+3]=meshVertex.TexCoords.v[j];;
        }
        [self.vertex setVertex:onevertex index:i];
    }
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
  
    
    self.elementVertex  = [VertexElement new];
    [self.elementVertex allocWithArray:self.indices];
    
}

-(void)draw:(AssimpBindObject * )bindObject{
    for (int i=0; i<self.textures.count; i++) {
        AssimpTextureUnit * unit = [self.textures objectAtIndex:i];
        [unit activeTextureUnit:GL_TEXTURE0+i];
        GLint location = -1;
        if ([unit.typeName isEqualToString:@"texture_diffuse"]) {
            location = uniform_diffuse;
        }else if ([unit.typeName isEqualToString:@"texture_height"]){
            location = uniform_height;

        }else if ([unit.typeName isEqualToString:@"texture_specular"]){
            location = uniform_specular;

        }
        [unit bindtextureUnitLocationAndShaderUniformSamplerLocation:bindObject->uniforms[location]];
    }
    
    
    [self.vertex enableVertexInVertexAttrib:aPos numberOfCoordinates:3 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:aTexCoords numberOfCoordinates:2 attribOffset:sizeof(float)*3];
    [self.elementVertex drawElementIndexWithMode:GL_TRIANGLES];
}

@end
