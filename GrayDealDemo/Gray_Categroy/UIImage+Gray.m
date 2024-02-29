//
//  UIImage+Gray.m
//  GrayDealDemo
//
//  Created by zl on 2024/2/24.
//

#import "UIImage+Gray.h"
#import <objc/runtime.h>

@implementation UIImage (Gray)

+ (void)xll_imageSwizzldMethedWith:(BOOL)changeGray {
    if (changeGray == NO) { return; }
    
    Class cls = object_getClass(self);  // 用于访问类方法
    
    NSArray *imageArray = @[@"imageNamed:", @"imageWithData:"];
    for (NSString *imageMethod in imageArray) {
        SEL originImageSel = NSSelectorFromString(imageMethod);
        SEL swizzledImageSel = NSSelectorFromString([NSString stringWithFormat:@"xll_%@", imageMethod]);
        
        Method originImageMethod = class_getClassMethod(cls, originImageSel);
        Method swizzledImageMethod = class_getClassMethod(cls, swizzledImageSel);
        
        [self swizzleMethodWithOriginSel:originImageSel oriMethod:originImageMethod swizzledSel:swizzledImageSel swizzledMethod:swizzledImageMethod class:cls];
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

+ (UIImage *)xll_imageWithData:(NSData *)data {
    UIImage *image = [self xll_imageWithData:data];
    return [image grayImage];
}

+ (UIImage *)xll_imageNamed:(NSString *)name {
    UIImage *image = [self xll_imageNamed:name];
    return [image grayImage];
}

// 转化灰度
- (UIImage *)grayImage {
    const int RED =1;
    const int GREEN =2;
    const int BLUE =3;

    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0,0, self.size.width* self.scale, self.size.height* self.scale);

    int width = imageRect.size.width;
    int height = imageRect.size.height;

    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t*) malloc(width * height *sizeof(uint32_t));

    // clear the pixels so any transparency is preserved
    memset(pixels,0, width * height *sizeof(uint32_t));

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height,8, width *sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);

    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context,CGRectMake(0,0, width, height), [self CGImage]);

    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t*) &pixels[y * width + x];

            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] +0.59 * rgbaPixel[GREEN] +0.11 * rgbaPixel[BLUE];

            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }

    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);

    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);

    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:UIImageOrientationUp];

    // we're done with image now too
    CGImageRelease(imageRef);

    return resultUIImage;
}
@end
