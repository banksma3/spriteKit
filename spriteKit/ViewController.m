//
//  ViewController.m
//  spriteKit
//
//  Created by Megan Banks on 6/29/15.
//  Copyright (c) 2015 Megan Banks. All rights reserved.
//

#import "ViewController.h"
#import "pictureStore.h"


@interface ViewController() <UICollisionBehaviorDelegate>

@property (strong, nonatomic) UIView *ballView;
@property (strong, nonatomic) UIView *backgroundView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIPushBehavior *pusher;
@property (nonatomic, strong) UICollisionBehavior *collider;
@property (nonatomic, strong) UIDynamicItemBehavior *ballDynamicProperties;
@property (nonatomic, strong) UIAttachmentBehavior *attacher;
    //@property (nonatomic, strong) pictureStore* picture;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        // self.picture = [[pictureStore alloc ]initWithImages];
    
        UIImage *backgroundImage = [UIImage imageNamed:@"images/tj/tj.png"];
    
    
    
    CGRect backFrame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - backgroundImage.size.width/2, [[UIScreen mainScreen] bounds].size.height/2 - backgroundImage.size.height/2, MIN([[UIScreen mainScreen] bounds].size.width, backgroundImage.size.width), MIN([[UIScreen mainScreen] bounds].size.height, backgroundImage.size.height));
    self.backgroundView = [[UIView alloc] initWithFrame:backFrame];
    self.backgroundView.layer.contents =(__bridge id)[UIImage imageNamed:@"images/tj/tj.png"].CGImage;
    [self.view addSubview:self.backgroundView];
    
    UIImage *cutoutImage = [UIImage imageNamed:@"images/tj/tjcutout.png"];

    CGRect ballFrame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.height/2 -138,cutoutImage.size.width, cutoutImage.size.height);
    self.ballView = [[UIView alloc] initWithFrame:ballFrame];
    [self.view addSubview:self.ballView];
    
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tapGR];
    
        // Better ball and paddle graphics
    self.ballView.layer.shadowOffset = CGSizeMake(5.0, 8.0);
    self.ballView.layer.shadowOpacity = 0.5;
    self.ballView.layer.contents = (__bridge id)[UIImage imageNamed:@"images/tj/tjcutout.png"].CGImage;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initBehaviors];
}

- (void)initBehaviors
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
        // Start ball off with a push
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[self.ballView]
                                                   mode:UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(1, 0);
        //Add speed
    
        self.pusher.magnitude = 01;
    self.pusher.active = YES; // Because push is instantaneous, it will only happen once
    [self.animator addBehavior:self.pusher];
    
        // Step 1: Add collisions
    self.collider = [[UICollisionBehavior alloc] initWithItems:@[self.ballView]];
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
    self.collider.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collider];
    
        // Step 2: Remove rotation
    self.ballDynamicProperties = [[UIDynamicItemBehavior alloc]
                                  initWithItems:@[self.ballView]];
    self.ballDynamicProperties.allowsRotation = NO;
    [self.animator addBehavior:self.ballDynamicProperties];
    
        // Step 4: Better collisions, no friction
    self.ballDynamicProperties.elasticity = 1.0;
    self.ballDynamicProperties.friction = 0.0;
    self.ballDynamicProperties.resistance = 0.0;
  
}

- (void)tapped:(UIGestureRecognizer *)gr
{
    
    CGPoint point = [self.ballView.superview convertPoint:self.ballView.frame.origin toView:self.view];
    NSLog(@"%f", point.x);
    if(abs(point.x - 198) < 10) {
        NSLog(@"YOU WON");
    }
    
 
    self.animator = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.animator = nil;
    self.collider = nil;
    self.pusher = nil;
}

- (void)reset
{
    [self.animator removeAllBehaviors];
    self.collider = nil;
    self.pusher = nil;
    self.ballDynamicProperties = nil;
    self.attacher = nil;
    
    self.ballView.frame = CGRectMake(100.0, 100.0, 64.0, 64.0);
    
    [self initBehaviors];
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
