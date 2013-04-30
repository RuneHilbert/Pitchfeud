//
//  UILabel+UILabel_TCCustomFont.m
//  PitchFeudV2
//
//  Created by Rune on 30/04/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "UILabel+UILabel_TCCustomFont.h"

@implementation UILabel (UILabel_TCCustomFont)

- (NSString *)fontName {
    return self.font.fontName;
}



- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
}

@end
