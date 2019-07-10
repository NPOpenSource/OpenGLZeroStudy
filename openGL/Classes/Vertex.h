//
//  Vertex.h
//  OpenGLUtils
//
//  Created by glodon on 2019/7/9.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Vertex : NSObject


-(void)allocVertexNum:(GLsizei)vertexNum andEachVertexNum:(GLsizei)eachVertexNum;
-(void)setVertex:(CGFloat *)vertex index:(NSInteger)index;
-(void)releaseVertex;

-(void)bindBufferWithUsage: (GLenum) usage;
-(void)enableVertexInVertexAttrib:(GLuint)index   numberOfCoordinates:(GLint)count attribOffset:(GLsizeiptr)offset;
-(void)drawVertexWithMode:(GLenum)mode  startVertexIndex:(GLint)first
         numberOfVertices:(GLsizei)count;
@end

NS_ASSUME_NONNULL_END
