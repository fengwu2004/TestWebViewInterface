//
//  EBWebInterfaceEvent.m
//  TestWebViewInterface
//
//  Created by admin on 2021/4/24.
//

#import "EBWebInterfaceEvent.h"
#import "EBWebInterface.h"

@interface EBWebInterfaceEvent ()


@end

@implementation EBWebInterfaceEvent

- (BOOL)isParamsValid {
    
    return YES;
}

- (void)excute {
    
    
}

- (void)finish {
    
    [_interface onWebCallBack:self];
}


@end
