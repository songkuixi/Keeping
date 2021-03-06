//
//  UIView+Extensions.m
//  Keeping
//
//  Created by 宋 奎熹 on 2018/5/28.
//  Copyright © 2018年 宋 奎熹. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

- (void)vibrateWithStyle:(UIImpactFeedbackStyle)style{
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:style];
    [generator prepare];
    [generator impactOccurred];
}

@end
