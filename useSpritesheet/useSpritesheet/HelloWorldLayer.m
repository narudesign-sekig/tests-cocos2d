//
//  HelloWorldLayer.m
//  useSpritesheet
//
//  Created by 関口 誠 on 2012/11/24.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild:bg];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sprites.plist"];
        
        CCSprite *sprite;
        
        sprite = [CCSprite spriteWithSpriteFrameName:@"heart.png"];
        [sprite setPosition:ccp(160, 100)];
        [self addChild:sprite];
        
        sprite = [CCSprite spriteWithSpriteFrameName:@"diamond.png"];
        [sprite setPosition:ccp(160, 200)];
        [self addChild:sprite];
        
        sprite = [CCSprite spriteWithSpriteFrameName:@"spade.png"];
        [sprite setPosition:ccp(160, 300)];
        [self addChild:sprite];
        
        sprite = [CCSprite spriteWithSpriteFrameName:@"club.png"];
        [sprite setPosition:ccp(160, 400)];
        [self addChild:sprite];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
