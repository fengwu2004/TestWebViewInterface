//
//  GdInterface.m
//  wret
//
//  Created by admin on 2021/4/13.
//

#import "EBWebInterface.h"
#import "EBWebInterfaceEvent.h"
#import "TestWebViewInterface-Swift.h"

//---------------------------------------------------------------------------------------------------------------------
@interface EBWebInterface()

@property(nonatomic) NSMutableDictionary<NSNumber*, EBWebInterfaceEvent *> *allEvents;
@property(atomic) NSInteger tempEventId;

@end


@implementation EBWebInterface

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _allEvents = [NSMutableDictionary new];
    }
    
    return self;
}

- (void)removeEvent:(NSInteger)eventId {
    
    @synchronized (self) {
        
        [_allEvents removeObjectForKey:@(eventId)];
    }
}

- (EBWebInterfaceEvent *)createEvent:(NSString *)functionId params:(NSDictionary *)params callbackId:(NSString *)callbackId {
    
    NSString *className = [NSString stringWithFormat:@"EBWebInterfaceEvent%@", functionId];
    
    Class eventClass = NSClassFromString(className);
    
    if (!eventClass) {

        return nil;
    }
   
    id obj = [eventClass new];
    
    if (![obj isKindOfClass:EBWebInterfaceEvent.class]) {
        
        return nil;
    }
    
    EBWebInterfaceEvent *event = obj;
    
    event.functionId = functionId;
    
    event.params = params;
    
    event.callBackId = callbackId;
    
    event.interface = self;
    
    @synchronized (self) {
        
        _tempEventId += 1;
        
        event.eventId = _tempEventId;
        
        _allEvents[@(event.eventId)] = event;
    }
    
    return event;
}

- (void)excute:(NSString *)functionId params:(NSDictionary *)params callbackId:(NSString *)callbackId {
    
    EBWebInterfaceEvent *event = [self createEvent:functionId params:params callbackId:callbackId];
    
    [event excute];
}

- (void)onWebCallBack:(EBWebInterfaceEvent *)event {
    
    NSDictionary *result = event.result;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:0 error:nil];
    
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *js = [NSString stringWithFormat:@"respFromNative(%@, '%@')", str, event.callBackId];
    
    [self evaluateScript:js];
    
    [self removeEvent:event.eventId];
}

- (void)evaluateScript:(NSString *)js {
    
    if (!js || js.length <= 0) {
        
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.webView evaluateJs:js];
    });
}

@end
