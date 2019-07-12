//
//  VertexElement.m
//  OpenGLUtils
//
//  Created by glodon on 2019/7/12.
//

#import "VertexElement.h"

@interface VertexElement()
@property (nonatomic, assign) GLuint indexBuffer;
@property (nonatomic ,assign)  GLuint  *indexs;
@property (nonatomic ,assign) GLsizei count ;

@end

@implementation VertexElement
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _customInit];
    }
    return self;
}

-(void)_customInit{
    glGenBuffers(1, &_indexBuffer);
}


-(void)allocWithIndexNum:(GLsizei)count  indexArr:(GLuint*)indexArr{
    if (self.indexs) {
        [self releaseIndexs];
    }
    self.count = count;
    self.indexs =(GLuint*)malloc(count *sizeof(GLuint));
    memset( self.indexs, 0,  count *sizeof(GLuint));
    for (int i =0; i<count; i++) {
        self.indexs[i]=indexArr[i];
    }
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, count *sizeof(GLuint),self.indexs, GL_STATIC_DRAW);
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

-(void)releaseIndexs{
    if (self.indexs) {
        free( self.indexs);
        self.indexs = NULL;
    }
}

-(void)drawElementIndexWithMode:(GLenum)mode{
     glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.indexBuffer);
     glDrawElements(mode, self.count, GL_UNSIGNED_INT,  0);
}

+ (void)drawElementIndexWithMode:(GLenum)mode indexNum:(GLsizei)count  indexArr:(GLuint*)indexArr
{
    glDrawElements(mode, count, GL_UNSIGNED_INT, indexArr);
}

- (void)dealloc
{
    [self releaseIndexs];
}


@end
