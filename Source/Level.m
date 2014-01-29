//
//  Level.m
//  BabyShower
//
//  Created by Andrew Moran on 1/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Level.h"

@implementation Level

- (void)didLoadFromCCB {
    CCLOG(@"level did load");
}

-(void) update:(CCTime)delta{
    CCLOG(@"my position %.02f %.02f", self.position.x, self.position.y);
    CGPoint pos = self.position;
    //pos.y += .05;
    self.position = pos;
}

@end
