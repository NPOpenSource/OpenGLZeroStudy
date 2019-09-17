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
    return self.getVertexWidth*self.vertexNum;
}
-(GLsizei)getVertexWidth{
    return sizeof(GLfloat) * self.eachVertexNum;
}

-(void)allocVertexNum:(GLsizei)vertexNum andEachVertexNum:(GLsizei)eachVertexNum{
    [self releaseVertex];
    self.vertexNum = vertexNum;
    self.eachVertexNum = eachVertexNum;
     self.vertex =(GLfloat*)malloc(self.getAllocSpaceByteNum);
    memset( self.vertex, 0,  self.getAllocSpaceByteNum);
}

-(void)setVertex:(GLfloat *)vertex index:(NSInteger)index{
    if (self.vertex) {
        NSInteger offset = index * self.eachVertexNum;
        for (NSInteger i = 0; i<self.eachVertexNum; i++) {
             self.vertex[offset+i] = vertex[i];
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

///通过指针设置buffer数据
-(void)writeBufferData{
    glBindBuffer(GL_ARRAY_BUFFER,
                 self.vertexBuffers);
        glBindBuffer(GL_ARRAY_BUFFER,
                     self.vertexBuffers);
        void *ptr = glMapBufferOES(GL_ARRAY_BUFFER, GL_WRITE_ONLY_OES);
        memcpy(ptr, self.vertex, self.getAllocSpaceByteNum);
        glUnmapBufferOES(GL_ARRAY_BUFFER);

}

-(void)writeBufferInOffset:(int)offset dataSize:(float)size Data:(void*)ptr{
    glBindBuffer(GL_ARRAY_BUFFER,
                 self.vertexBuffers);
    glBufferSubData(GL_ARRAY_BUFFER, offset, size, ptr);
}

-(void)enableVertexInVertexAttrib:(GLuint)index  numberOfCoordinates:(GLint)count attribOffset:(GLsizeiptr)offset vertexWidth:(GLsizei)width{
    glBindBuffer(GL_ARRAY_BUFFER,
                 self.vertexBuffers);
    glEnableVertexAttribArray(index);
    glVertexAttribPointer(index,               // Identifies the attribute to use
                          count,               // number of coordinates for attribute
                          GL_FLOAT,            // data is floating point
                          GL_FALSE,            // no fixed point scaling
                          width ,         // total num bytes stored per vertex
                          NULL + offset);
#ifdef DEBUG
    {  // Report any errors
        GLenum error = glGetError();
        if(GL_NO_ERROR != error)
        {
            NSLog(@"[GL Error]: enableVertex  0x%x", error);
        }
    }
    //    GL_INVALID_OPERATION  operation;
    //    GL_INVALID_VALUE
#endif
}

-(void)enableVertexInVertexAttrib:(GLuint)index  numberOfCoordinates:(GLint)count attribOffset:(GLsizeiptr)offset{
    [self enableVertexInVertexAttrib:index numberOfCoordinates:count attribOffset:offset vertexWidth:[self getVertexWidth]];
}


-(void)drawVertexWithMode:(GLenum)mode  startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count {
    NSAssert([self getAllocSpaceByteNum] >=
             ((first + count) *sizeof(GLfloat) * self.eachVertexNum),
             @"Attempt to draw more vertex data than available.");
    glBindBuffer(GL_ARRAY_BUFFER,
                 self.vertexBuffers);
     glDrawArrays(mode, first, count);
}

-(void)drawVertexWithMode:(GLenum)mode  startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count RepeatCount:(GLsizei)repeatCount {
    glBindBuffer(GL_ARRAY_BUFFER,
                 self.vertexBuffers);
    glDrawArraysInstancedEXT(mode, first,count, repeatCount);

}

-(void)setVertexDivisor:(GLuint) index  divisor:(GLuint)divisor{
    glBindBuffer(GL_ARRAY_BUFFER,
                 self.vertexBuffers);
    glVertexAttribDivisorEXT(2,1);
}

- (void)dealloc
{
    [self releaseVertex];
}

@end
