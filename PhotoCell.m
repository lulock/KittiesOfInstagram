//
//  PhotoCellCollectionViewCell.m
//  Photo Bombers
//
//  Created by Lulu on 2015-08-02.
//  Copyright (c) 2015 Lulu. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoController.h"

@implementation PhotoCell

-(void) setPhoto:(NSDictionary *)photo{
    _photo = photo;
    
    [PhotoController imageForPhoto:_photo size:@"thumbnail" completion:^(UIImage *image){
        self.imageView.image = image;
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

-(void) like{
//    NSLog(@"Link: %@", _photo[@"link"]);
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@", _photo[@"id"], accessToken];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@"response: %@", response);
//        NSLog(@"data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLikeCompletion];
        });
    }];
    
    [task resume];
    
}

-(void) showLikeCompletion{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Liked!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        
        double delayInSeconds = 1.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        });
}
@end
