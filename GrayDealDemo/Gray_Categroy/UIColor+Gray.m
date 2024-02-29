//
//  UIColor+Gray.m
//  GrayDealDemo
//
//  Created by zl on 2024/2/24.
//

#import "UIColor+Gray.h"
#import <objc/runtime.h>

@implementation UIColor (Gray)

+ (void)xll_colorSwizzldMethedWith:(BOOL)changeGray {
    if (changeGray == NO) { return; }
    
    Class cls = object_getClass(self);
    
    SEL originSel = @selector(colorWithRed:green:blue:alpha:);
    SEL swizzledSel = @selector(xll_colorWithRed:green:blue:alpha:);
    
    Method originMethod = class_getClassMethod(cls, originSel);
    Method swizzledMethod = class_getClassMethod(cls, swizzledSel);
    
    [self swizzleMethodWithOriginSel:originSel oriMethod:originMethod swizzledSel:swizzledSel swizzledMethod:swizzledMethod class:cls];
    
    NSArray *colorArray = @[@"redColor", @"greenColor", @"blueColor", @"cyanColor", @"yellowColor", @"magentaColor", @"orangeColor", @"purpleColor", @"brownColor", @"systemBlueColor", @"systemGreenColor"];
    
    for (NSString *colorMethod in colorArray) {
        SEL originColorSel = NSSelectorFromString(colorMethod);
        SEL swizzledColorSel = NSSelectorFromString([NSString stringWithFormat:@"xll_%@", colorMethod]);
        
        Method originColorMethod = class_getClassMethod(cls, originColorSel);
        Method swizzledColorMethod = class_getClassMethod(cls, swizzledColorSel);
        
        [self swizzleMethodWithOriginSel:originColorSel oriMethod:originColorMethod swizzledSel:swizzledColorSel swizzledMethod:swizzledColorMethod class:cls];
    }
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

+ (instancetype)xll_colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
    return [self changeGrayWithRed:r green:g blue:b alpha:a];
}

+ (UIColor *)changeGrayWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
    CGFloat gray = r * 0.299 + g * 0.587 + b * 0.114;
    UIColor *grayColor = [UIColor colorWithWhite:gray alpha:a];
    return grayColor;
}

+ (UIColor *)xll_redColor {
    return [self changeGrayWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
}
+ (UIColor *)xll_greenColor {
    return [self changeGrayWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
}
+ (UIColor *)xll_blueColor {
    return [self changeGrayWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
}
+ (UIColor *)xll_cyanColor {
    return [self changeGrayWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
}
+ (UIColor *)xll_yellowColor {
    return [self changeGrayWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
}
+ (UIColor *)xll_magentaColor {
    return [self changeGrayWithRed:1.0 green:0.0 blue:1.0 alpha:1.0];
}
+ (UIColor *)xll_orangeColor {
    return [self changeGrayWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
}
+ (UIColor *)xll_purpleColor {
    return [self changeGrayWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];
}
+ (UIColor *)xll_brownColor {
    return [self changeGrayWithRed:0.6 green:0.4 blue:0.2 alpha:1.0];
}
+ (UIColor *)xll_systemBlueColor {
    return [self changeGrayWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
}
+ (UIColor *)xll_systemGreenColor {
    return [self changeGrayWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
}

@end
