//
//  MainScene.m
//  testUITableView
//
//  Created by 関口 誠 on 2012/11/18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainScene.h"
#import "TitleScene.h"

#define N_OF_SECTION    3
#define N_OF_ROW        5

@implementation MainScene
{
    UITableView *table;
    int count[N_OF_SECTION];
}
+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    MainScene *layer = [MainScene node];
    [scene addChild: layer];
    return  scene;
}

- (id) init
{
    if (self = [super init])
    {
        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(127, 127, 127, 255)];
        [self addChild:bg];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Main Scene"
                                               fontName:@"Marker Felt"
                                               fontSize:64];
        label.position = ccp(160, 400);
        [self addChild:label];
        
        CCMenuItem *itemMenu = [CCMenuItemFont itemWithString:@"go Title" block:^(id sender) {
            [table setContentOffset:table.contentOffset animated:NO];   // stop scrolling
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[TitleScene scene]]];
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

- (void) onEnterTransitionDidFinish
{
    for (int i = 0; i < N_OF_SECTION; i++)
    {
        count[i] = N_OF_ROW;
    }
    
    CGRect frame = CGRectMake(20, 120, 280, 240);
    table = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    table.layer.cornerRadius = 5;
    table.layer.borderColor = [UIColor blackColor].CGColor;
    table.layer.borderWidth = 2;
    table.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    table.separatorColor = [UIColor blackColor];
    table.rowHeight = 70;
    table.allowsSelection = NO;     // cell can't select
    table.alpha = 0;
    table.dataSource = self;
    table.delegate = self;
    [[[CCDirector sharedDirector] view] addSubview:table];
    
    [UIView animateWithDuration:0.1 animations:^(void){
        table.alpha = 1.0;
    }];
}

- (void) onExitTransitionDidStart
{
    [table removeFromSuperview];
    table = nil;
    [table release];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellCustom";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UIImageView *pict;
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        pict = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)] autorelease];
        pict.tag = 1;
        [cell.contentView addSubview:pict];
    }
    else
    {
        pict = (UIImageView *)[cell.contentView viewWithTag:1];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    pict.image = img;
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return N_OF_SECTION;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return count[section];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 + (float)indexPath.row / 20.0 blue:0.0 alpha:1.0];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    count[indexPath.section]--;
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
