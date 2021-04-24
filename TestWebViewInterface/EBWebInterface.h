//
//  GdInterface.h
//  wret
//
//  Created by admin on 2021/4/13.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


NS_ASSUME_NONNULL_BEGIN

@protocol EBWebInterfaceExport<JSExport>

JSExportAs(excute, - (void)excute:(NSString *)functionId params:(nullable NSDictionary *)params callbackId:(nullable NSString *)callbackId);

@end

@class EBWebInterfaceEvent;
@class EBWebView;

//---------------------------------------------------------------------------------------------------------------------
@interface EBWebInterface : NSObject <EBWebInterfaceExport>

@property(nonatomic, weak) EBWebView *webView;

- (void)evaluateScript:(NSString *)js;

- (void)onWebCallBack:(EBWebInterfaceEvent *)event;


@end

NS_ASSUME_NONNULL_END
