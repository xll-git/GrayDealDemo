//
//  UIColor+Hex.m
//  GrayDealDemo
//
//  Created by zl on 2024/2/24.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(int)hex {
    CGFloat r = ((hex & 0xFF0000) >> 16) / 255.0;
    CGFloat g = ((hex & 0x00FF00) >> 8 ) / 255.0;
    CGFloat b = ((hex & 0x0000FF)      ) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    if (hexString == nil) { return [UIColor blackColor]; }
    
    NSString *useString = [hexString lowercaseString];
    if ([useString hasPrefix:@"0x"]) {
        useString = [useString substringFromIndex:2];
    }
    if ([useString hasPrefix:@"#"]) {
        useString = [useString substringFromIndex:1];
    }
    if (useString.length == 6) {
        unsigned rgbValue = 0;
        [[NSScanner scannerWithString:useString] scanHexInt:&rgbValue];
        CGFloat r = ((rgbValue & 0xFF0000) >> 16) / 255.0;
        CGFloat g = ((rgbValue & 0x00FF00) >> 8 ) / 255.0;
        CGFloat b = ((rgbValue & 0x0000FF)      ) / 255.0;
        return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    }else if (useString.length == 3) {
        unsigned rgbValue = 0;
        [[NSScanner scannerWithString:useString] scanHexInt:&rgbValue];
        CGFloat r = ((rgbValue & 0xF00) >> 8) / 255.0;
        CGFloat g = ((rgbValue & 0x0F0) >> 4) / 255.0;
        CGFloat b = ((rgbValue & 0x00F)     ) / 255.0;
        return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    } else {
        return [UIColor blackColor];
    }
    return [UIColor blackColor];
}

- (NSString *)hexString {
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    NSString *red = [NSString stringWithFormat:@"%02x", (int)(r * 255)];
    NSString *green = [NSString stringWithFormat:@"%02x", (int)(g * 255)];
    NSString *blue = [NSString stringWithFormat:@"%02x", (int)(b * 255)];
    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
}

@end
