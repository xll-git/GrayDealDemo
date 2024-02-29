//
//  UIColor+Hex.h
//  GrayDealDemo
//
//  Created by zl on 2024/2/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(int)hex;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
- (NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
