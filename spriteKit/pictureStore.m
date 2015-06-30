//
//  pictureStore.m
//  spriteKit
//
//  Created by Megan Banks on 6/30/15.
//  Copyright (c) 2015 Megan Banks. All rights reserved.
//

#import "pictureInfo.h"
#import "pictureStore.h"

@implementation pictureStore
-(instancetype) initWithImages {
    self = [super init];
    if(self)  {
        NSError *error = nil;
        
        NSArray *desktopFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Users/meganbanks/Desktop/spriteKit/spriteKit/images" error:&error];
        for (NSString *images in desktopFiles) {
            NSMutableString *path = [NSMutableString stringWithString: @"/Users/meganbanks/Desktop/spriteKit/spriteKit/images/"];
            [path appendString:images];
            
            NSArray *Files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
            if(Files!=nil) {
                pictureInfo *picture = [[pictureInfo alloc]init];
                picture.background = [Files objectAtIndex:1];
                picture.cutout = [Files objectAtIndex:2];
                self.pictures = [self.pictures setByAddingObject:picture];
            }
        }
        NSLog(@"@%@", error.localizedDescription);
    }
    return self;
}
@end
