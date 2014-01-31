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
#import "Banner.h"

CCNode* level;
NSString* openText1 = @"The baby is on the way...";
NSString* openText2 = @"Tilt left \n \n ";
NSString* openText3 = @"Tilt right \n \n ";

NSString* openText4 = @"Press Down \n \n ";
NSString* openText5 = @"Release \n \n ";

NSString* openText6 = @"Fill your happy meter below. \nBefore baby gets upset.";
NSString* openText7 = @"Avoid the obstacles, \nor baby gets mad.";
NSString* openText8 = @"Congrats, tutorial done.";


NSString* currentText;
int currentLevel;

BOOL isTutorial;
BOOL isStarting;

float levelSpeed;

@implementation DropScene{
    BabyBoy *_fallingBaby;
    HudDisplay *_hud;
    CCLabelTTF *_title;
    Banner *_banner;
    CCPhysicsNode *_worldPhysics;
    //CCNode *_level;
    CCBAnimationManager *animationManager;
}

//@synthesize audioPlayer;

-(id)init{
    if (self = [super init]){
        bubbles = [[NSMutableArray alloc] init];
        levelContainer = [[NSMutableArray alloc] init];

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
        [self performSelector:@selector(LoadStage1) withObject:nil afterDelay:4.0f];
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
    
    [self instructionsText:openText2];
    [_hud setCloudIm:@"TiltLeft":YES];
    
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
    [_banner changeTextWeak:@"Tutorial"];
    
    
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
        [levelContainer addObject:[levelContents objectAtIndex:i]];
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
    
    CCLOG( @"current container is %.02d", [levelContainer count]);

    if (isStarting == NO){
        
        for (int i=0; i<[levelContainer count]; i++) {
            if( [[levelContainer objectAtIndex:i] isKindOfClass:[SmallBubble class]] ){
                SmallBubble *bub = [levelContainer objectAtIndex:i];
                if (bub.position.y > 420 ){
                    [levelContainer removeObjectAtIndex:i];
                }
            }
            else if( [[levelContainer objectAtIndex:i] isKindOfClass:[Branch class]] ){
                Branch *branch = [levelContainer objectAtIndex:i];
                if (branch.position.y > 420 ){
                    [levelContainer removeObjectAtIndex:i];
                }
            }
        }

        
        /*
        for( int i = 0; i<[bubbles count]; i++){
            SmallBubble *bub = [bubbles objectAtIndex:i];
            if (bub.position.y > 420 ){
                [bubbles removeObjectAtIndex:i];
            }
        }
         */
        
        if( [levelContainer count] == 0){
            nextLevel = YES;
        }
    
        if (nextLevel == YES){
            switch (currentLevel) {
                case 0:
                    [self instructionsText:openText3];
                    [_hud setCloudIm:@"TiltRight": YES];
                    [_hud setCloudIm:@"TiltLeft": NO];
                    [self updateLevel];
                    break;
                case 1:
                    [self instructionsText:openText2];
                    [_hud setCloudIm:@"TiltRight": NO];
                    [_hud setCloudIm:@"TiltLeft": YES];
                    [self updateLevel];
                    break;
                case 2:
                    [self instructionsText:openText3];
                    [_hud setCloudIm:@"TiltRight": YES];
                    [_hud setCloudIm:@"TiltLeft": NO];
                    [self updateLevel];
                    break;
                case 3:
                    [self instructionsText:openText4];
                    [_hud setCloudIm:@"TiltRight": NO];
                    [_hud setCloudIm:@"TiltLeft": NO];
                    [_hud setCloudIm:@"PressDown": YES];
                    _fallingBaby.isDeactive = NO;
                    _fallingBaby.deactiveY = NO;
                    [self updateLevel];
                    break;
                case 4:
                    [self instructionsText:openText5];
                    [_hud setCloudIm:@"PressUp": YES];
                    [_hud setCloudIm:@"PressDown": NO];
                    [self updateLevel];
                    break;
                case 5:
                    [self instructionsText:openText4];
                    [_hud setCloudIm:@"PressUp": NO];
                    [_hud setCloudIm:@"PressDown": YES];
                    [self updateLevel];
                    break;
                case 6:
                    [self instructionsText:openText5];
                    [_hud setCloudIm:@"PressUp": YES];
                    [_hud setCloudIm:@"PressDown": NO];
                    [self updateLevel];
                    break;
                case 7:
                    levelSpeed = 1.2f;
                    [self updateLevel];
                    [_hud setCloudIm:@"PressUp": NO];
                    [self instructionsText:openText6];
                    [_hud setHappyMeter:true];

                    break;
                case 8:
                    [self instructionsText:openText7];
                    [self updateLevel];
                    break;
                case 9:
                    [self instructionsText:openText8];
                    break;
                default:
                    break;
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
    [levelContainer removeObject:bubbleNode];

    
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
