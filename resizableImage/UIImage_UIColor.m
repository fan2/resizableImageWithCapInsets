//
//  UIImage_UIColor.m
//  resizableImage
//
//  Created by faner on 16/4/22.
//  Copyright © 2016年 faner. All rights reserved.
//

#import "UIImage_UIColor.h"

@implementation UIImage (UIColor)

+ (UIImage*)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 4.0f, 4.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage* colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

+ (UIImage*)resizableImageFromColor:(UIColor *)color
{
    UIColor* bgColor = color;
    if(!bgColor) {
        bgColor = RGBCOLOR(229.0, 230.0, 231.0); // default
    }
    
    UIImage* colorImage = [UIImage imageFromColor:bgColor];
    // return RESIZABLE_IMAGE_BY_STRETCHING_CENTER_PIXEL(colorImage);
    return [colorImage resizableImageWithCapInsets:CENTER_PIXEL_CAPINSETS_OF_IMAGE(colorImage)];
}

@end
