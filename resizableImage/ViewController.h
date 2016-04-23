//
//  ViewController.h
//  resizableImage
//
//  Created by faner on 15/9/3.
//  Copyright © 2015年 faner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *topImgView;
@property (weak, nonatomic) IBOutlet UIImageView *botImgView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIImageView *friendBubbleImgView;
@property (weak, nonatomic) IBOutlet UILabel *friendMsgLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myselfBubbleImgView;
@property (weak, nonatomic) IBOutlet UILabel *myselftMsgLabel;

@property (weak, nonatomic) IBOutlet UIButton *leftAgreeButton;
@property (weak, nonatomic) IBOutlet UIButton *rightAgainstButton;

- (IBAction)onLeftBtnClick:(id)sender;
- (IBAction)onRightBtnClick:(id)sender;

@end

