//
//  MetaDataView.m
//  Photo Bombers
//
//  Created by Lulu on 2015-08-09.
//  Copyright (c) 2015 Lulu. All rights reserved.
//

#import "MetaDataView.h"
#import <SAMCategories/NSDate+SAMAdditions.h>

@interface MetaDataView ()
@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UIButton *usernameButton;
@property (nonatomic) UIButton *timeButton;
@property (nonatomic) UIButton *likesButton;
@property (nonatomic) UIButton *commentsButton;
@end
@implementation MetaDataView

-(void) setPhoto:(NSDictionary *)photo{
    _photo = photo;
    //set timeButton
    NSDate *createdAt = [NSDate dateWithTimeIntervalSince1970:[_photo[@"created_time"] doubleValue]];
    [self.timeButton setTitle:[createdAt sam_briefTimeInWords] forState:UIControlStateNormal];
    //set avatarImageView
    NSString *urlString = photo[@"user"][@"profile_picture"];
    NSURL *imageURL = [[NSURL alloc] initWithString:urlString];
    NSData *urlData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *avatar = [[UIImage alloc] initWithData:urlData];
    self.avatarImageView.image = avatar;

    //set usernameButton
    NSString *username = [[NSString alloc] initWithFormat: @"%@", _photo[@"user"][@"username"]];
    [self.usernameButton setTitle:username forState:UIControlStateNormal];
    
    //set likesButton
    NSString *likes = [[NSString alloc] initWithFormat: @"%@", _photo[@"likes"][@"count"]];
    [self.likesButton setTitle:likes forState:UIControlStateNormal];
    
    //set commentsButton
    NSString *comments = [[NSString alloc] initWithFormat: @"%@", _photo[@"comments"][@"count"]];
    [self.commentsButton setTitle:comments forState:UIControlStateNormal];
}

#pragma mark - Actions

-(void) openUser:(id)sender {
    //open link in Safari to user profile
}

-(void) openPhoto:(id)sender {
    //open link in Safari to photo page
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.avatarImageView];
        [self addSubview:self.usernameButton];
        [self addSubview:self.timeButton];
        [self addSubview:self.likesButton];
        [self addSubview:self.commentsButton];

    }
    return self;
}

-(CGSize) sizeThatFits:(CGSize)size{
    //dno why this size try to understand
    return CGSizeMake(320.0f, 400.0f);
}

#pragma mark - UIViewControl

-(UIImageView *)avatarImageView {
    if (!_avatarImageView){
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 32.0f, 32.0f)];
        _avatarImageView.layer.cornerRadius = 16.0f;
        _avatarImageView.layer.borderColor = [[self class] darkTextColor].CGColor;
        _avatarImageView.layer.borderWidth = 1.0f;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0f];
        _avatarImageView.userInteractionEnabled = NO;
    }
    return _avatarImageView;
}

-(UIButton *)usernameButton {
    if (!_usernameButton){
        _usernameButton = [[UIButton alloc] initWithFrame:CGRectMake(47.0f, 0.0f, 200.0f, 32.0f)];
        _usernameButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _usernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UIColor *textColor = [[self class] darkTextColor];
        [_usernameButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    return _usernameButton;
}

-(UIButton *)timeButton {
    if (!_timeButton){
        _timeButton = [[UIButton alloc] initWithFrame:CGRectMake(260.0f, 0.0f, 50.0f, 32.0f)];
        _timeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        
        [_timeButton setImage:[UIImage imageNamed:@"time"] forState:UIControlStateNormal];
        _timeButton.adjustsImageWhenHighlighted = NO;
        _timeButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        
        _timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

        UIColor *textColor = [[self class] darkTextColor];
        [_timeButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    return _timeButton;
}

-(UIButton *)likesButton {
    if (!_likesButton){
        _likesButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 360.0f, 50.0f, 40.0f)];
        _likesButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        
        [_likesButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        _likesButton.adjustsImageWhenHighlighted = NO;
        _likesButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        
        _likesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        
        UIColor *textColor = [[self class] darkTextColor];
        [_likesButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    return _likesButton;
}

-(UIButton *)commentsButton {
    if (!_commentsButton){
        _commentsButton = [[UIButton alloc] initWithFrame:CGRectMake(260.0f, 360.0f, 50.0f, 40.0f)];
        _commentsButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        
        [_commentsButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        _commentsButton.adjustsImageWhenHighlighted = NO;
        _commentsButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        _commentsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

        
        UIColor *textColor = [[self class] darkTextColor];
        [_commentsButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    return _commentsButton;
}

#pragma mark - Private

+ (UIColor *)darkTextColor {
    return [UIColor colorWithRed:0.849f green:0.410f blue:0.280f alpha:1.0f];
}


+ (UIColor *)lightTextColor {
    return [UIColor colorWithRed:0.973f green:0.753f blue:0.686f alpha:1.0f];
}

@end
