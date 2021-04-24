//
//  EBWebInterfaceEvent.h
//  TestWebViewInterface
//
//  Created by admin on 2021/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class EBWebInterface;

@interface EBWebInterfaceEvent : NSObject

@property(nonatomic) NSString *functionId;
@property(nonatomic) NSDictionary *params;
@property(nonatomic) NSString *callBackId;

@property(atomic) NSInteger eventId;
@property(nonatomic) NSDictionary *result;
@property(nonatomic, weak) EBWebInterface *interface;

//override
- (void)excute;

- (void)finish;

@end

NS_ASSUME_NONNULL_END
