//
//  SphereManager.h
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/2.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SphereManager : NSObject
+( unsigned int)getVertexNum;
+(float *)getSphereVerts;
+(float *)getSphereNormals;
+(float *)getSphereTexCoords;
@end

NS_ASSUME_NONNULL_END
