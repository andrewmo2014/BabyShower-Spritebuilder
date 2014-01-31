//
//  Banner.m
//  BabyDrop
//
//  Created by Andrew Moran on 1/26/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Banner.h"

@implementation Banner{
    CCNode *_bannerType;
    CCLabelTTF *_bannerText;
}

-(void)changeTextWeak: (NSString *)string{
    [_bannerText setString: string];
}

@end
