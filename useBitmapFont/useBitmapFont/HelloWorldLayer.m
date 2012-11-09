//
//  HelloWorldLayer.m
//  testSlider
//
//  Created by 関口 誠 on 2012/11/09.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer {
    CCLabelBMFont *counter;
    int count;
}

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
	if( (self=[super init]) ) {
		
        count = 0;
        
        counter = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%04d", count]fntFile:@"font.fnt"];
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		counter.position =  ccp( size.width /2 , size.height/2 );
        counter.scale = 10;
        [[counter texture] setAliasTexParameters];
		[self addChild: counter];
        
        [self schedule:@selector(nextFrame:)];
	}
	return self;
}

-(void)nextFrame:(ccTime)dt
{
    count++;
    if (count > 9999)
        count = 0;
    
    [counter setString:[NSString stringWithFormat:@"%04d", count]];
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
