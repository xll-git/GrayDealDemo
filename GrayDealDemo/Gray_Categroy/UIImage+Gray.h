//
//  UIImage+Gray.h
//  GrayDealDemo
//
//  Created by zl on 2024/2/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Gray)

+ (void)xll_imageSwizzldMethedWith:(BOOL)changeGray;
- (UIImage *)grayImage; //转化灰度

@end

NS_ASSUME_NONNULL_END
