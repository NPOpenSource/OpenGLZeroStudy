//
//  CubeManager.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CubeManager : NSObject
+(unsigned int)getNormalVertexNum;
+(float *)getNormalVertexs;

+(unsigned int)getVertexNum;
+(float *)getCubeVerts;
+(float *)getCubeNormals;
+(float *)cubeColors;
+(GLuint *)getVertexElements;
+(unsigned int)getVertexElementsNum;
@end

NS_ASSUME_NONNULL_END
