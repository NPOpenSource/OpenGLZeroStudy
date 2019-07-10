//
//  Vertex.m
//  OpenGLUtils
//
//  Created by glodon on 2019/7/9.
//

#import "Vertex.h"

@interface Vertex()

@property (nonatomic ,assign)   GLfloat  *vertex; ;
@property (nonatomic ,assign) GLsizei vertexNum ;
@property (nonatomic ,assign) GLsizei eachVertexNum ;
@property (nonatomic, assign) GLuint vertexBuffers;
@property (nonatomic ,assign) GLenum usage ;
@end

@implementation Vertex

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _customInit];
    }
    return self;
}

-(void)_customInit{
     glGenBuffers(1, &_vertexBuffers);
}

-(NSInteger)getAllocSpaceByteNum{
    return sizeof(GLfloat) * self.eachVertexNum*self.vertexNum;
}

-(void)allocVertexNum:(GLsizei)vertexNum andEachVertexNum:(GLsizei)eachVertexNum{
    [self releaseVertex];
    self.vertexNum = vertexNum;
    self.eachVertexNum = eachVertexNum;
     self.vertex =(GLfloat*)malloc(self.getAllocSpaceByteNum);
    memset( self.vertex, 0,  sizeof(GLfloat)*eachVertexNum*vertexNum);
}

-(void)setVertex:(CGFloat *)vertex index:(NSInteger)index{
    if (self.vertex) {
        NSInteger offset = index * self.eachVertexNum;
        for (NSInteger i = 0; i<self.eachVertexNum; i++) {
             _vertex[offset] = vertex[i];
        }
    }else{
        NSLog(@"顶点没有空间");
    }
}

-(void)releaseVertex{
    if (self.vertex) {
        free( self.vertex);
         self.vertex = NULL;
    }
}

-(void)bindBufferWithUsage: (GLenum) usage{
    if (!self.vertexBuffers) {
        [self _customInit];
    }
    glBindBuffer(GL_ARRAY_BUFFER,
                 self.vertexBuffers);
    glBufferData( GL_ARRAY_BUFFER,
                 self.getAllocSpaceByteNum,
                  self.vertex,
                 usage);
    
}

-(void)enableVertexInVertexAttrib:(GLuint)index   numberOfCoordinates:(GLint)count attribOffset:(GLsizeiptr)offset{
    glEnableVertexAttribArray(index);
    glVertexAttribPointer( index,               // Identifies the attribute to use
                          count,               // number of coordinates for attribute
                          GL_FLOAT,            // data is floating point
                          GL_FALSE,            // no fixed point scaling
                          self.eachVertexNum,         // total num bytes stored per vertex
                          NULL + offset);
#ifdef DEBUG
    {  // Report any errors
        GLenum error = glGetError();
        if(GL_NO_ERROR != error)
        {
            NSLog(@"GL Error: 0x%x", error);
        }
    }
#endif
}
-(void)drawVertexWithMode:(GLenum)mode  startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count {
    NSAssert([self getAllocSpaceByteNum] >=
             ((first + count) *sizeof(GLfloat) * self.eachVertexNum),
             @"Attempt to draw more vertex data than available.");
     glDrawArrays(mode, first, count);
}

- (void)dealloc
{
    [self releaseVertex];
}

@end
