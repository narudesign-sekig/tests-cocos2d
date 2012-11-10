//
//  HelloWorldLayer.m
//  spriteDragAndDrop
//
//  Created by 関口 誠 on 2012/11/10.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer
{
    CCSprite *sp;
    CGPoint po;
    CGFloat poMinX;
    CGFloat poMaxX;
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
		
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        sp = [[CCSprite alloc] initWithFile:@"squareOrange.png"];
        sp.position = ccp(size.width / 2, size.height * 0.6);
        [self addChild:sp];
        
        po = ccp(-999, -999);
        poMinX = sp.boundingBox.size.width * 0.5;
        poMaxX = size.width - sp.boundingBox.size.width * 0.5;
        
        self.isTouchEnabled = YES;
	}
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint poNow = [touch locationInView:[touch view]];
    poNow = [[CCDirector sharedDirector] convertToGL:poNow];
    
    if (CGRectContainsPoint(sp.boundingBox, poNow))
    {
        printf("*** ccTouchesBegan (x:%f, y:%f)\n", poNow.x, poNow.y);
        po = poNow;
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint poNow = [touch locationInView:[touch view]];
    poNow = [[CCDirector sharedDirector] convertToGL:poNow];
    
    if (po.x >= 0)
    {
        CGFloat x = sp.position.x + poNow.x - po.x;
        
        if (x < poMinX) x = poMinX;
        if (x > poMaxX) x = poMaxX;
        
        sp.position = ccp(x, sp.position.y);
        po = poNow;
        
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (po.x >= 0)
    {
        printf("ccTouchesEnded:\n\n");
        po = ccp(-999, -999);
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
