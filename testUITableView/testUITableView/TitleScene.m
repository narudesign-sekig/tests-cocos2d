//
//  TitleScene.m
//  testUITableView
//
//  Created by 関口 誠 on 2012/11/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TitleScene.h"
#import "MainScene.h"

@implementation TitleScene
{
}

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    TitleScene *layer = [TitleScene node];
    [scene addChild: layer];
    return  scene;
}

- (id) init
{
    if (self = [super init])
    {
        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(127, 127, 127, 255)];
        [self addChild:bg];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Title Scene"
                                               fontName:@"Marker Felt"
                                               fontSize:64];
        label.position = ccp(160, 400);
        [self addChild:label];
        
        CCMenuItem *itemMenu = [CCMenuItemFont itemWithString:@"go Main" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MainScene scene]]];
        }];
        CCMenu *menu = [CCMenu menuWithItems:itemMenu, nil];
        menu.position = ccp(160, 80);
        [self addChild:menu];
    }
    return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
