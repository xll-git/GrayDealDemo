//
//  WKWebView+Gray.m
//  GrayDealDemo
//
//  Created by zl on 2024/2/29.
//

#import "WKWebView+Gray.h"
#import <objc/runtime.h>

@implementation WKWebView (Gray)

+ (void)xll_WKWebViewWizzldMethedWith:(BOOL)changeGray {
    if (changeGray == NO) { return; }
    
    Class cls = [self class];  // 用于访问实例方法
    
    SEL originSel = @selector(initWithFrame:configuration:);
    SEL swizzledSel = @selector(xll_initWithFrame:configuration:);
    
    Method originMethod = class_getInstanceMethod(cls, originSel);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSel);
    
    [self swizzleMethodWithOriginSel:originSel oriMethod:originMethod swizzledSel:swizzledSel swizzledMethod:swizzledMethod class:cls];
}

+ (void)swizzleMethodWithOriginSel:(SEL)oriSel
                         oriMethod:(Method)oriMethod
                       swizzledSel:(SEL)swizzledSel
                    swizzledMethod:(Method)swizzledMethod
                             class:(Class)cls {
    BOOL didAddMethod = class_addMethod(cls, oriSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swizzledMethod);
    }
}

- (instancetype)xll_initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    if (configuration != nil) {
        configuration = [[WKWebViewConfiguration alloc] init];
    }
    // js脚本
    NSString *jScript = @"var filter = '-webkit-filter:grayscale(100%);-moz-filter:grayscale(100%); -ms-filter:grayscale(100%); -o-filter:grayscale(100%) filter:grayscale(100%);';document.getElementsByTagName('html')[0].style.filter = 'grayscale(100%)';";
    // 注入
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    if (configuration.userContentController == nil) {
        configuration.userContentController = [[WKUserContentController alloc] init];
    }
    [configuration.userContentController addUserScript:wkUScript];
    
    WKWebView *webView = [self xll_initWithFrame:frame configuration:configuration];
    return webView;
}
@end
