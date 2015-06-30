//
//  pictureStore.h
//  spriteKit
//
//  Created by Megan Banks on 6/30/15.
//  Copyright (c) 2015 Megan Banks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pictureStore : NSObject
@property (nonatomic, strong) NSSet *pictures;

-(instancetype) initWithImages NS_DESIGNATED_INITIALIZER;
@end
