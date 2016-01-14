//
//  DetailViewController.m
//  Photo Bombers
//
//  Created by Lulu on 2015-08-09.
//  Copyright (c) 2015 Lulu. All rights reserved.
//

#import "DetailViewController.h"
#import "PhotoController.h"
#import "MetadataView.h"

@interface DetailViewController ()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) MetaDataView *metaDataView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    self.view.clipsToBounds = YES;
    
    self.metaDataView = [[MetaDataView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 400.0f)];
    self.metaDataView.alpha = 0.0f;
    self.metaDataView.photo = self.photo;
    [self.view addSubview:self.metaDataView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, -320.0, 320.0f, 320.0f)];
    [self.view addSubview:self.imageView];
    
    [PhotoController imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tap];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}

-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    CGPoint point = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:point];
    [self.animator addBehavior:snap];
    
    self.metaDataView.center = point;
    [UIView animateWithDuration:0.5 delay:0.7 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:kNilOptions animations:^{
        self.metaDataView.alpha = 1.0f;
    } completion:nil];
}

//- (void) viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    
//    CGSize size = self.view.bounds.size;
//    CGSize imageSize = CGSizeMake(size.width, size.width);
//    self.imageView.frame = CGRectMake(0, (size.height - imageSize.height)/2.0, imageSize.width, imageSize.height);
//
//}

- (void) close {
    [self.animator removeAllBehaviors];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.imageView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) + 180.0f)];
    [self.animator addBehavior:snap];

    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
