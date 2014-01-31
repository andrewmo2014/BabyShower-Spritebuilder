//
//  SmallBubble.m
//  BabyShower
//
//  Created by Andrew Moran on 1/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SmallBubble.h"

@implementation SmallBubble

@synthesize speed;
@synthesize audioPlayer;


-(id) init{
    if (self = [super init]){
        speed = 0.0f;
        NSString *mp3Path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"comedy_bubble_pop_003.mp3"];
        NSURL *mp3Url = [NSURL fileURLWithPath:mp3Path];
        
        AVAudioPlayer *audPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3Url error:NULL];
        [self setAudioPlayer:audPlayer];

    }
    return self;
}

-(void)didLoadFromCCB {
    CCLOG( @"bubble logged");
    self.physicsBody.collisionType = @"bubble";
}

-(void)update:(CCTime)delta{
    CGPoint pos = self.position;
    pos.y += speed;
    self.position = pos;
}


@end
