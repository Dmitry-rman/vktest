//
//  UIImage+resize.h
//  WordsGame
//
//  Created by Дмитрий on 24.02.16.
//  Copyright © 2016 R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(resize)
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
- (UIImage*)makeRoundCornersWithRadius:(const CGFloat)RADIUS;
@end
