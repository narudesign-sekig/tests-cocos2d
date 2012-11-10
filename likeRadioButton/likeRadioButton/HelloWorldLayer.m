//
//  HelloWorldLayer.m
//  likeRadioButton
//
//  Created by 関口 誠 on 2012/11/10.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

//#define IMG_NORMAL_1    @"normal1.png"
//#define IMG_PRESSED_1   @"pressed1.png"
//#define IMG_SELECTED_1  @"selected1.png"
//#define IMG_NORMAL_2    @"normal2.png"
//#define IMG_PRESSED_2   @"pressed2.png"
//#define IMG_SELECTED_2  @"selected2.png"

#define IMG_NORMAL_1    @"rad_normal1.png"
#define IMG_PRESSED_1   @"rad_pressed1.png"
#define IMG_SELECTED_1  IMG_PRESSED_1
#define IMG_NORMAL_2    @"rad_normal2.png"
#define IMG_PRESSED_2   @"rad_pressed2.png"
#define IMG_SELECTED_2  IMG_PRESSED_2

// HelloWorldLayer implementation
@implementation HelloWorldLayer
{
    CCMenuItemImage *item1_;
    CCMenuItemImage *item2_;
    int selected_;
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
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
        selected_ = 1;
        
        item1_ = [CCMenuItemImage itemWithNormalImage:IMG_SELECTED_1
                                        selectedImage:IMG_PRESSED_1
                                               target:self selector:@selector(pressMenuItem:)];
        item1_.position = ccp(-55, 0);
        
        item2_ = [CCMenuItemImage itemWithNormalImage:IMG_NORMAL_2
                                        selectedImage:IMG_PRESSED_2
                                               target:self selector:@selector(pressMenuItem:)];
        item2_.position = ccp(55, 0);
        
        CCMenu *menu = [CCMenu menuWithItems:item1_, item2_, nil];
        
        [self addChild:menu];
	}
	return self;
}

- (void) pressMenuItem:(id)sender
{
    CCMenuItemImage *item = (CCMenuItemImage *)sender;
    
    if (item == item1_)
    {
        [item1_ setNormalImage:[CCSprite spriteWithFile:IMG_SELECTED_1]];
        [item2_ setNormalImage:[CCSprite spriteWithFile:IMG_NORMAL_2]];
        selected_ = 1;
    }
    else
    {
        [item1_ setNormalImage:[CCSprite spriteWithFile:IMG_NORMAL_1]];
        [item2_ setNormalImage:[CCSprite spriteWithFile:IMG_SELECTED_2]];
        selected_ = 2;
    }
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

@end