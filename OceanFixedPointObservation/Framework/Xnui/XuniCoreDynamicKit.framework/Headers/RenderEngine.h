//
//  RenderEngine.h
//  XuniCore
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "IRenderEngine.h"

/**
*  XuniRenderEngine クラス
*/
@interface XuniRenderEngine : NSObject <IXuniRenderEngine>
/**
*  XuniRenderEngine オブジェクトを初期化します。
*    @return XuniRenderEngine オブジェクト
*/
- (id)init;
@end
