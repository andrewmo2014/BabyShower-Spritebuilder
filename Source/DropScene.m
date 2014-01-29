//
//  DropScene.m
//  BabyDrop
//
//  Created by Andrew Moran on 1/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "DropScene.h"
#import "BabyBoy.h"
#import "HudDisplay.h"
#import "SmallBubble.h"

CCNode* level;

@implementation DropScene{
    BabyBoy *_fallingBaby;
    HudDisplay *_hud;
    CCLabelTTF *_title;
    CCPhysicsNode *_worldPhysics;
    //CCNode *_level;
}

@synthesize audioPlayer;

-(id)init{
    if (self = [super init]){
        bubbles = [[NSMutableArray alloc] init];
        nextLevel = NO;
        
        NSString *mp3Path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"comedy_bubble_pop_003.mp3"];
        NSURL *mp3Url = [NSURL fileURLWithPath:mp3Path];
        
        AVAudioPlayer *audPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3Url error:NULL];
        [self setAudioPlayer:audPlayer];
        
    }
    return self;
}

-(void) onEnter{
    [super onEnter];
    _hud.changeCloudText = YES;
    _fallingBaby.isDeactive = NO;
}

// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    //_worldPhysics.debugDraw = TRUE;
    _hud.myLabel = _title;
    _worldPhysics.collisionDelegate = self;
    
    level = [CCBReader loadAsScene:@"Level00"];
    [_worldPhysics addChild:level];
    //_levelNode = level;
    
    [self resetBubbleCount];
    

    
}

-(void) resetBubbleCount{
    NSArray* levelContents = [[level getChildByName:@"ContentManager" recursively:YES] children];
    for (int i=0; i<[levelContents count]; i++) {
        if( [[levelContents objectAtIndex:i] isKindOfClass:[SmallBubble class]] ){
            SmallBubble *bub = [levelContents objectAtIndex:i];
            bub.speed = .0005f;
            [bubbles addObject: [levelContents objectAtIndex:i]];
        }
    }
}


-(void) nextLevel:(int) num{
    
    NSInteger i = num;
    NSString *levelName = @"Level0";
    NSString* myLevelNum = [NSString stringWithFormat:@"%@%d", levelName, i];
    
    level = [CCBReader loadAsScene:myLevelNum];
    [_worldPhysics addChild:level];
    
    
    //_levelNode = level;
    
    //CCBAnimationManager* animationManager = level.userObject;
    //[animationManager runAnimationsForSequenceNamed:@"levelMove"];
    
}

// called on every touch in this scene

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    _fallingBaby.slowDown = YES;
    
}

-(void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    _fallingBaby.slowDown = NO;
}

-(void) update:(CCTime)delta{
    
    //CCLOG( @"%d", bubbles.count );

    if( bubbles.count == 0){
        nextLevel = YES;
    }
    
    if (nextLevel == YES){
        CCLOG(@"changing Level");
        [self nextLevel:1];
        [self resetBubbleCount];
        nextLevel = NO;
    }
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair baby:(CCNode *)babyNode bubble:(CCNode *)bubbleNode{
    CCLOG( @"collision occurred");
    [bubbleNode removeFromParent];
    [bubbles removeObject:bubbleNode];
    [audioPlayer play];
    
    
    return YES;
}

@end
