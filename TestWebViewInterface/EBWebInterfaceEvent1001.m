//
//  EBWebInterfaceEvent1001.m
//  TestWebViewInterface
//
//  Created by admin on 2021/4/24.
//

#import "EBWebInterfaceEvent1001.h"

@implementation EBWebInterfaceEvent1001

- (void)excute {
    
    __weak EBWebInterfaceEvent1001 *wealSelf = self;
    
    [self doSomeHttpRquest:^{
        
        __strong EBWebInterfaceEvent1001 *strongSelf = wealSelf;
        
        strongSelf.result = @{@"success":@(1), @"value":@"我是xxx"};
        
        [strongSelf finish];
    }];
}

- (void)doSomeHttpRquest:(void(^)(void))success {
    
    if (success) {
        
        success();
    }
}


@end
