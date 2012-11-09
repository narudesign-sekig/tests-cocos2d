//
//  TitleLayer.m
//  testButton
//
//  Created by 関口 誠 on 2012/11/08.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TitleLayer.h"
#import "MainLayer.h"

@implementation TitleLayer
{
    UIButton *button;
    UISlider *slider;
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	TitleLayer *layer = [TitleLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Title Scene" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position =  ccp( size.width /2 , size.height/2 + 100 );        // cocos2d : (0, 0)=(Left, Bottom)
		[self addChild: label];
        
	}
	return self;
}

- (void) onEnter
{
    UIView *view = [[CCDirector sharedDirector] view];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 220, 50)];
    slider.center = CGPointMake(size.width / 2, size.height / 2);
    slider.alpha = 0;
    [view addSubview:slider];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Go Main" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 220, 50);
    button.center = CGPointMake(size.width / 2, size.height / 2 + 100);  // uikit : (0, 0)=(Left, Top)
    [button addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
    button.alpha = 0;
    [view addSubview:button];
    [UIView animateWithDuration:0.2 animations:^(void)
     {
         slider.alpha = 1;
         button.alpha = 1;
     }];
}

-(void) onExitTransitionDidStart
{
    [slider removeFromSuperview];
    slider = nil;
    
    [button removeFromSuperview];
    button = nil;
}
- (void) dealloc
{
	[super dealloc];
}

- (void)buttonTap
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.2 scene:[MainLayer scene]]];
}

@end
