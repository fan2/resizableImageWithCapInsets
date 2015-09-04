//
//  ViewController.h
//  resizableImage
//
//  Created by faner on 15/9/3.
//  Copyright © 2015年 faner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnLeftAgree;
@property (weak, nonatomic) IBOutlet UIButton *btnRightAgainst;
@property (weak, nonatomic) IBOutlet UIImageView *topImgView;
@property (weak, nonatomic) IBOutlet UIImageView *botImgView;

- (IBAction)onLeftBtnClick:(id)sender;
- (IBAction)onRightBtnClick:(id)sender;
@end

