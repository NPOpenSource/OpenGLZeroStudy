//
//  Vertex.h
//  OpenGLUtils
//
//  Created by glodon on 2019/7/9.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>
NS_ASSUME_NONNULL_BEGIN

@interface Vertex : NSObject

///通过指针设置buffer数据 先调用 bindBufferWithUsage 再调用setVertex 那么需要调用下该函数将数据写入
-(void)writeBufferData;
///通过指针设置buffer数据 先调用 bindBufferWithUsage 再调用setVertex 那么需要调用下该函数将数据写入该函数是写入多个属性的顶点数据
-(void)writeBufferInOffset:(int)offset dataSize:(float)size Data:(void*)ptr;

-(void)allocVertexNum:(GLsizei)vertexNum andEachVertexNum:(GLsizei)eachVertexNum;
-(void)setVertex:(GLfloat *)vertex index:(NSInteger)index;
-(void)releaseVertex;

-(void)bindBufferWithUsage: (GLenum) usage;

///从顶点buffer中获取顶点数据的两种方式
-(void)enableVertexInVertexAttrib:(GLuint)index   numberOfCoordinates:(GLint)count attribOffset:(GLsizeiptr)offset;
-(void)enableVertexInVertexAttrib:(GLuint)index  numberOfCoordinates:(GLint)count attribOffset:(GLsizeiptr)offset vertexWidth:(GLsizei)width;

-(void)drawVertexWithMode:(GLenum)mode  startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count;
///一次性绘制
-(void)drawVertexWithMode:(GLenum)mode  startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count RepeatCount:(GLsizei)repeatCount;

/**
 设置分割顶点

 @param index 分割的顶点宽度
 @param divisor 一次取顶点宽度多少个
 参考实例化demo使用.  可能上述描述不是很准确
 */
-(void)setVertexDivisor:(GLuint) index  divisor:(GLuint)divisor;
@end

NS_ASSUME_NONNULL_END
