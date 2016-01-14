//
//  PhotoController.h
//  Photo Bombers
//
//  Created by Lulu on 2015-08-09.
//  Copyright (c) 2015 Lulu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoController : UIViewController

+(void) imageForPhoto:(NSDictionary *) photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;

@end
