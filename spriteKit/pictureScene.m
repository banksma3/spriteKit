//
//  pictureScene.m
//  spriteKit
//
//  Created by Megan Banks on 6/29/15.
//  Copyright (c) 2015 Megan Banks. All rights reserved.
//

#import "pictureScene.h"

@interface pictureScene()
@property BOOL contentCreated;
@property int animating;
@end


@implementation pictureScene
-(void)didMoveToView:(SKView *)view {
    if(!self.contentCreated ) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

-(void) createSceneContents {
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild: [self newBackgroundPictureNode]];
    [self addChild:[self newPictureNode]];
    self.animating = 0;
    [self animationLoop:nil finished: [NSNumber numberWithBool:YES] context:nil];
}

-(SKSpriteNode *) newPictureNode {
    SKSpriteNode *pictureNode = [[SKSpriteNode alloc]initWithImageNamed:@"firstbox.jpeg"];
    pictureNode.size = CGSizeMake(275, 125);
    pictureNode.name = @"cutout";
    pictureNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    return pictureNode;
}

-(SKSpriteNode *) newBackgroundPictureNode {
    SKSpriteNode *pictureNode = [[SKSpriteNode alloc]initWithImageNamed:@"firstpic.jpeg"];
    pictureNode.size = self.size;
    pictureNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    return pictureNode;
}
//-(void) beginAnimating {
//    SKNode *pictureNode = [self childNodeWithName:@"cutout"];
//    if(pictureNode!=nil) {
//        
//      
//        self.animating = YES;
//        pictureNode.name = nil;
//            UIBezierPath *randomPath = [UIBezierPath bezierPath];
//            [randomPath moveToPoint:CGPointMake(0, 0)];
//            [randomPath addLineToPoint:[self RandomPoint:self.frame]];
//            SKAction *move = [SKAction followPath:[randomPath CGPath] speed:100];
//            [pictureNode runAction:move];
//    
//    }
//}
    
    -(void)animationLoop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
        if(self.animating >100) {
            return;
        }
        self.animating ++;
        SKNode *pictureNode = [self childNodeWithName:@"cutout"];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        
        CGFloat x = (CGFloat) (arc4random() % (int) self.view.bounds.size.width);
        CGFloat y = (CGFloat) (arc4random() % (int) self.view.bounds.size.height);
        
        CGPoint squarePostion = CGPointMake(x, y);
        pictureNode.position = squarePostion;
            // add:
        [UIView setAnimationDelegate:self]; // as suggested by @Carl Veazey in a comment
        [UIView setAnimationDidStopSelector:@selector(animationLoop:finished:context:)];
        [UIView commitAnimations];
        NSLog(@"ANimated");
    }
-(CGPoint) RandomPoint:(CGRect) bounds {
    CGPoint point = CGPointMake(CGRectGetMinX(bounds) + arc4random() % (int) CGRectGetWidth(bounds), CGRectGetMinY(bounds) + arc4random() % (int) CGRectGetHeight(bounds));
    NSLog(@"%f, %f", point.x, point.y);
    return point;
}
@end
