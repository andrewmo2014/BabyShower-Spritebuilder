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
#import "Branch.h"

CCNode* level;
NSString* openText1 = @"The baby is on the way...";
NSString* openText2 = @"Tilt to move left or right.\nTry popping the bubbles.";
NSString* openText3 = @"Press the screen to move up,\nRelease to fall back down.";
NSString* openText4 = @"Bubbles fill the baby's happy meter,\nKeep popping and avoid obstacles";

NSString* currentText;
int currentLevel;

BOOL isTutorial;
BOOL isStarting;

float levelSpeed;

@implementation DropScene{
    BabyBoy *_fallingBaby;
    HudDisplay *_hud;
    CCLabelTTF *_title;
    CCPhysicsNode *_worldPhysics;
    //CCNode *_level;
    CCBAnimationManager *animationManager;
}

//@synthesize audioPlayer;

-(id)init{
    if (self = [super init]){
        bubbles = [[NSMutableArray alloc] init];
        nextLevel = NO;
        isTutorial = YES;
        isStarting = YES;
        levelSpeed = 0.0f;
        
        //NSString *mp3Path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"comedy_bubble_pop_003.mp3"];
        //NSURL *mp3Url = [NSURL fileURLWithPath:mp3Path];
        
        //AVAudioPlayer *audPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3Url error:NULL];
        //[self setAudioPlayer:audPlayer];
        
    }
    return self;
}

-(void) onEnter{
    [super onEnter];
    
    if( isTutorial ){
        currentLevel = 0;
        currentText = openText1;
        _fallingBaby.isDeactive = YES;
        [self performSelector:@selector(instructionsText:) withObject:openText1 afterDelay:0.0f];
        [self performSelector:@selector(instructionsText:) withObject:openText2 afterDelay:4.0f];
        [self performSelector:@selector(LoadStage1) withObject:nil afterDelay:7.0f];
    }
}

-(void)instructionsText: (NSString *)string{
    CCLOG(@"called text");
    [_hud changeTextWeak:string];
}

-(void)LoadStage1{
    CCLOG(@"called loadInit");
    level = [CCBReader loadAsScene:@"Level00"];
    [_worldPhysics addChild:level];
    //_levelNode = level;
    
    [self resetBubbleCount];
    _fallingBaby.isDeactive = NO;
    _fallingBaby.deactiveY = YES;
    
    isStarting = NO;

}

-(void)LoadStage2{
    //CCLOG(@"called loadInit");
    //level = [CCBReader loadAsScene:@"Level00"];
    //[_worldPhysics addChild:level];
    //_levelNode = level;
    
    //[self resetBubbleCount];
    
    
    _fallingBaby.isDeactive = NO;
    _fallingBaby.deactiveY = NO;
    [self updateLevel];
    
}

// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    
    
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    //_worldPhysics.debugDraw = TRUE;
    //_hud.myLabel = _title;
    _worldPhysics.collisionDelegate = self;
    animationManager = self.userObject;
    animationManager.delegate = self;
    
    [_hud setPauseButtonVisible];
    

    
    
    //Lets Do tutorial first
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //level = [CCBReader loadAsScene:@"Level00"];
    //[_worldPhysics addChild:level];
    //_levelNode = level;
    
    //[self resetBubbleCount];
    

    
}

-(void) resetBubbleCount{
    NSArray* levelContents = [[level getChildByName:@"ContentManager" recursively:YES] children];
    for (int i=0; i<[levelContents count]; i++) {
        if( [[levelContents objectAtIndex:i] isKindOfClass:[SmallBubble class]] ){
            CCLOG(@"i found a bubble");
            SmallBubble *bub = [levelContents objectAtIndex:i];
            bub.speed = levelSpeed;
            [bubbles addObject: [levelContents objectAtIndex:i]];
        }
        if( [[levelContents objectAtIndex:i] isKindOfClass:[Branch class]] ){
            CCLOG(@"found a branch");
            Branch *branch = [levelContents objectAtIndex:i];
            branch.speed = levelSpeed;
        }
    }
    
    [level.userObject runAnimationsForSequenceNamed:@"levelMove"];
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
    
    //CCLOG( @"current level is %.02d", currentLevel);

    if (isStarting == NO){
        
        for( int i = 0; i<[bubbles count]; i++){
            SmallBubble *bub = [bubbles objectAtIndex:i];
            if (bub.position.y > 1 ){
                [bubbles removeObjectAtIndex:i];
            }
        }
        
        if( bubbles.count == 0){
            nextLevel = YES;
        }
    
        if (nextLevel == YES){
            if( currentLevel < 4 ){
                [self updateLevel];
            }
            if( currentLevel >= 4 && currentLevel < 8 ){
                if( currentLevel == 4 ){
                    [self performSelector:@selector(instructionsText:) withObject:openText3 afterDelay:0.0f];
                    [self performSelector:@selector(LoadStage2) withObject:nil afterDelay:4.0f];
                }
                else{
                    [self updateLevel];
                }
            }
            
            if( currentLevel >= 8 ){
                if( currentLevel == 8 ){
                    levelSpeed = 1.2f;
                    [self performSelector:@selector(instructionsText:) withObject:openText4 afterDelay:0.0f];
                    [self updateLevel];
                    [_hud setHappyMeter:true];

                }
                //else{
                //    [self updateLevel];
                //}
            }
            
        }
        
    }
}
    
-(void)updateLevel{
    nextLevel = NO;
    currentLevel++;
    CCLOG(@"changing Level");
    [self nextLevel:currentLevel];
    [self resetBubbleCount];
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair baby:(CCNode *)babyNode bubble:(CCNode *)bubbleNode{
    CCLOG( @"I hit a bubble");
    [[(SmallBubble*)bubbleNode audioPlayer] play];
    [bubbleNode removeFromParent];
    [bubbles removeObject:bubbleNode];
    
    if (_hud.happyMeterResizing == YES){
        _hud.happyMeterLength = clampf(_hud.happyMeterLength+.03f, 0.0f, 1.0f);
    }

    //[audioPlayer play];
    
    
    return YES;
}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair baby:(CCNode *)babyNode branch:(CCNode *)branchNode{
    CCLOG( @"I hit a branch");
    
    if (_hud.happyMeterResizing == YES){
        _hud.happyMeterLength = clampf(_hud.happyMeterLength-.06f, 0.0f, 1.0f);
    }
    
    return YES;
}

-(void) completedAnimationSequenceNamed:(NSString *)name{
    
}



@end
