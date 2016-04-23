//
//  UIImage_UIColor.h
//  resizableImage
//
//  Created by faner on 16/4/22.
//  Copyright © 2016年 faner. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define INTERIOR_PIXEL_CAPINSETS_OF_IMAGE(topCap, leftCap) \
                                                UIEdgeInsetsMake(topCap,leftCap,topCap+1,leftCap+1)
#define RESIZABLE_IMAGE_BY_INTERIOR_PIXEL(img, topCap, leftCap) \
                                                img = [img resizableImageWithCapInsets:INTERIOR_PIXEL_CAPINSETS_OF_IMAGE(topCap, leftCap)]

// UIImage的中心点拉伸封盖：center 1 x 1 pixel region
#define CENTER_PIXEL_CAPINSETS_OF_IMAGE(img)    INTERIOR_PIXEL_CAPINSETS_OF_IMAGE(img.size.height/2,img.size.width/2)
/*
 #define RESIZABLE_IMAGE_BY_STRETCHING_CENTER_PIXEL(img) \
 img = [img resizableImageWithCapInsets:CENTER_PIXEL_CAPINSETS_OF_IMAGE(img)]
 */
#define RESIZABLE_IMAGE_BY_STRETCHING_CENTER_PIXEL(img) \
                                                RESIZABLE_IMAGE_BY_INTERIOR_PIXEL(img, img.size.height/2,img.size.width/2)

@interface UIImage (UIColor)
+ (UIImage*)imageFromColor:(UIColor *)color;
+ (UIImage*)resizableImageFromColor:(UIColor *)color;
@end
