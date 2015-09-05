//
//  ViewController.m
//  resizableImage
//
//  Created by faner on 15/9/3.
//  Copyright © 2015年 faner. All rights reserved.
//

#import "ViewController.h"

// RGB颜色
#define RGBCOLOR(r,g,b)                 [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

// 纵向ImageView圆角半径为7pixel=3.5point
#define IMGVIEW_CORNER_RADIUS           4
// top_half_bg@2x.png拉伸矩形区域
#define TOP_IMGVIEW_CAPINSETS           UIEdgeInsetsMake(IMGVIEW_CORNER_RADIUS,IMGVIEW_CORNER_RADIUS,0,IMGVIEW_CORNER_RADIUS)
// bot_half_bg@2x.png拉伸矩形区域
#define BOT_IMGVIEW_CAPINSETS           UIEdgeInsetsMake(0,IMGVIEW_CORNER_RADIUS,IMGVIEW_CORNER_RADIUS,IMGVIEW_CORNER_RADIUS)

// 登录按钮圆角半径为14pixel=7pt
#define LOGIN_BTN_CORNER_RADIUS         7
// 上下左右各保留7pt，scale/resize the interior area through tile or stretch
#define LOGIN_BTN_CAPINSETS             UIEdgeInsetsMake(LOGIN_BTN_CORNER_RADIUS,LOGIN_BTN_CORNER_RADIUS,LOGIN_BTN_CORNER_RADIUS,LOGIN_BTN_CORNER_RADIUS)

// 胶囊按钮贴图圆角半径为40pixel=20pt
#define BARBTN_CORNER_RADIUS            20
// 椭圆背景宽度
#define BARBTN_BGIMG_WIDTH              25
// 左边胶囊拉伸矩形区域，保留左椭圆及右边框（上下各保留2pt），一个pt窄带拉伸
#define LEFT_BARBTN_CAPINSETS           UIEdgeInsetsMake(2,BARBTN_CORNER_RADIUS,2,BARBTN_BGIMG_WIDTH-BARBTN_CORNER_RADIUS-1)
// 右边胶囊拉伸矩形区域，保留右椭圆及左边框（上下各保留2pt），一个pt窄带拉伸
#define RIGHT_BARBTN_CAPINSETS          UIEdgeInsetsMake(2,BARBTN_BGIMG_WIDTH-BARBTN_CORNER_RADIUS-1,2,BARBTN_CORNER_RADIUS)



@interface ViewController ()

@end

@implementation ViewController

// 将按钮的type从System修改为Custom，否则默认按下tintColor为蓝色！

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**************************************************************************/
    //// 纵向ImageView贴图示例
    /**************************************************************************/
    /// 上半部背景
    UIImage* topBgImage = [UIImage imageNamed:@"top_half_bg.png"];
    NSLog(@"topBgImage.resizingMode=%zd, topBgImage.capInsets=%@.",
          topBgImage.resizingMode, // 默认为UIImageResizingModeTile
          NSStringFromUIEdgeInsets(topBgImage.capInsets)); // 默认为UIEdgeInsetsZero
    // topBgImage = [topBgImage resizableImageWithCapInsets:TOP_IMGVIEW_CAPINSETS  resizingMode:UIImageResizingModeStretch];
    //  stretching the is 1 x 1 pixel region, provides the fastest performance.
    UIEdgeInsets topBgEdgeInset = UIEdgeInsetsMake(topBgImage.size.width/2, topBgImage.size.height/2,
                                                  topBgImage.size.width/2-1, topBgImage.size.height/2-1);
    topBgImage = [topBgImage resizableImageWithCapInsets:topBgEdgeInset];
    _topImgView.image = topBgImage;
    
    /// 下半部背景
    UIImage* botBgImage = [UIImage imageNamed:@"bot_half_bg.png"];
    botBgImage = [botBgImage resizableImageWithCapInsets:BOT_IMGVIEW_CAPINSETS]; // UIImageResizingModeTile
    _botImgView.image = botBgImage;
    
    /**************************************************************************/
    //// 登录按钮示例
    /**************************************************************************/
    UIFont* loginBtnFont = [UIFont boldSystemFontOfSize:16];
    NSString* loginBtnTitle = @"登录";
    // （1）背景
    UIImage* loginBtnBg = [UIImage imageNamed:@"login_btn_bg.tiff"];
    // 按钮高度大于背景贴图，直接stretching the interior 1-pixel region会有问题!
    // UIEdgeInsets loginBtnBgEdgeInset = UIEdgeInsetsMake(loginBtnBg.size.width/2, loginBtnBg.size.height/2, loginBtnBg.size.width/2-1, loginBtnBg.size.height/2-1);
    // tiling the interior area not covered by the cap
    loginBtnBg = [loginBtnBg resizableImageWithCapInsets:LOGIN_BTN_CAPINSETS];
    [_btnLogin setBackgroundImage:loginBtnBg forState:UIControlStateNormal];
    // （2）标题，默认titleLabel.textAlignment = NSTextAlignmentCenter
    _btnLogin.titleLabel.font = loginBtnFont;
    [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnLogin setTitle:loginBtnTitle forState:UIControlStateNormal];
    
    /**************************************************************************/
    //// 聊天气泡示例
    /**************************************************************************/
    UIFont* msgFont = [UIFont systemFontOfSize:14];
    NSString* friendMsg = @"😀今天晚上有空吗，要不要一起去海边兜兜风？";
    NSString* myselfMsg = @"😘好的。你大概几点过来呢？";
    _friendBubbleMsg.textAlignment = NSTextAlignmentLeft;
    _friendBubbleMsg.numberOfLines = 0;
    // _friendBubbleMsg.lineBreakMode = NSLineBreakByWordWrapping; // default
    _friendBubbleMsg.font = msgFont;
    _friendBubbleMsg.text = friendMsg;
    UIImage* friendBubbleBg = [UIImage imageNamed:@"Chat_Bubble_Friend.tiff"];
    // 左侧向下拉伸会出现三个箭头！！！
    // friendBubbleBg = [friendBubbleBg resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 5)];
    // 保留箭头所在上半部分，向下向右填充
    friendBubbleBg = [friendBubbleBg resizableImageWithCapInsets:UIEdgeInsetsMake(24, 15, 5, 5)];
    _friendBubbleImgView.image = friendBubbleBg;
    
    _myselfBubbleMsg.textAlignment = NSTextAlignmentLeft;
    _myselfBubbleMsg.numberOfLines = 0;
    // _myselfBubbleMsg.lineBreakMode = NSLineBreakByWordWrapping; // default
    _myselfBubbleMsg.font = msgFont;
    _myselfBubbleMsg.text = myselfMsg;
    UIImage* myselfBubbleBg = [UIImage imageNamed:@"Chat_Bubble_Myself.tiff"];
    // 左侧向下拉伸会出现三个箭头！！！
    // myselfBubbleBg = [myselfBubbleBg resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 15)];
    // 保留箭头所在上半部分，向下向右填充
    myselfBubbleBg = [myselfBubbleBg resizableImageWithCapInsets:UIEdgeInsetsMake(24, 5, 5, 15)];
    _myselfBubbleImgView.image = myselfBubbleBg;
    
    /**************************************************************************/
    //// 横向胶囊按钮示例
    /**************************************************************************/
    UIFont* titleFont = [UIFont systemFontOfSize:15];
    NSString* leftBtnTitle = @"赞同";
    NSString* rightBtnTile = @"反对";
    /// 左侧胶囊按钮，constaints固定高度为40pt
    // （1）背景
    UIImage* leftNorBgImg = [UIImage imageNamed:@"left_barbtn_bg_normal.png"];
    // leftNorBgImg = [leftNorBgImg resizableImageWithCapInsets:LEFT_BARBTN_CAPINSETS]; // tiling
    //  stretching the is 1 x 1 pixel region, provides the fastest performance.
    UIEdgeInsets leftBgEdgeInset = UIEdgeInsetsMake(leftNorBgImg.size.width/2, leftNorBgImg.size.height/2,
                                                    leftNorBgImg.size.width/2-1, leftNorBgImg.size.height/2-1);
    leftNorBgImg = [leftNorBgImg resizableImageWithCapInsets:leftBgEdgeInset];
    [_btnLeftAgree setBackgroundImage:leftNorBgImg forState:UIControlStateNormal];
    
    UIImage* leftSelBgImg = [UIImage imageNamed:@"left_barbtn_bg_selected.png"];
    leftSelBgImg = [leftSelBgImg resizableImageWithCapInsets:LEFT_BARBTN_CAPINSETS]; // tiling
    [_btnLeftAgree setBackgroundImage:leftSelBgImg forState:UIControlStateSelected];
    // （2）图标（adjustsImageWhenHighlighted），默认UIViewContentModeScaleToFill
    UIImage* leftNorImg =  [UIImage imageNamed:@"left_barbtn_agree_img_normal.tiff"];
    [_btnLeftAgree setImage:leftNorImg forState:UIControlStateNormal];
    UIImage* leftSelImg = [UIImage imageNamed:@"left_barbtn_agree_img_selected.tiff"];
    [_btnLeftAgree setImage:leftSelImg forState:UIControlStateSelected];
    // 默认图标在左侧，标题在右侧，整体居中。这里给图标右侧预留4pt间隔
    // CGFloat verInset = (CGRectGetHeight(_btnLeftAgree.frame)-leftNorImg.size.height)/2;
    [_btnLeftAgree setImageEdgeInsets:UIEdgeInsetsMake(0/*verInset*/, 0, 0/*verInset*/, 8)];
    // （3）标题，默认titleLabel.textAlignment = NSTextAlignmentCenter
    _btnLeftAgree.titleLabel.font = titleFont;
    [_btnLeftAgree setTitleColor:RGBCOLOR(0x29, 0xb4, 0xeb) forState:UIControlStateNormal];
    [_btnLeftAgree setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnLeftAgree setTitle:leftBtnTitle forState:UIControlStateNormal];
    // 默认图标在左侧，标题在右侧，整体居中。这里给标题左侧预留4pt间隔，与图标间距8pt。
    [_btnLeftAgree setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    
    /// 右侧胶囊按钮，constaints固定高度为40pt
    // （1）背景
    UIImage* rightNorBgImg = [UIImage imageNamed:@"right_barbtn_bg_normal.png"];
    rightNorBgImg = [rightNorBgImg resizableImageWithCapInsets:RIGHT_BARBTN_CAPINSETS resizingMode:UIImageResizingModeStretch];
    [_btnRightAgainst setBackgroundImage:rightNorBgImg forState:UIControlStateNormal];
    
    UIImage* rightSelBgImg = [UIImage imageNamed:@"right_barbtn_bg_selected.png"];
    rightSelBgImg = [rightSelBgImg resizableImageWithCapInsets:RIGHT_BARBTN_CAPINSETS resizingMode:UIImageResizingModeStretch];
    [_btnRightAgainst setBackgroundImage:rightSelBgImg forState:UIControlStateSelected];
    // （2）图标（adjustsImageWhenHighlighted），UIViewContentModeScaleToFill
    UIImage* rightNorImg = [UIImage imageNamed:@"left_barbtn_against_img_normal.tiff"];
    [_btnRightAgainst setImage:rightNorImg forState:UIControlStateNormal];
    UIImage* rightSelImg = [UIImage imageNamed:@"left_barbtn_against_img_selected.tiff"];
    [_btnRightAgainst setImage:rightSelImg forState:UIControlStateSelected];
    // （3）标题，默认titleLabel.textAlignment = NSTextAlignmentCenter
    _btnRightAgainst.titleLabel.font = titleFont;
    [_btnRightAgainst setTitleColor:RGBCOLOR(0x29, 0xb4, 0xeb) forState:UIControlStateNormal];
    [_btnRightAgainst setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnRightAgainst setTitle:rightBtnTile forState:UIControlStateNormal];
    /// 默认图标在左侧，标题在右侧，整体居中。
    
    // 为方便测试，为imageView和titleLabel添加边框
//    _btnLeftAgree.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
//    _btnLeftAgree.imageView.layer.borderWidth = 1.0;
//    _btnLeftAgree.titleLabel.layer.borderColor = [UIColor blueColor].CGColor;
//    _btnLeftAgree.titleLabel.layer.borderWidth = 1.0;
//    _btnRightAgainst.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
//    _btnRightAgainst.imageView.layer.borderWidth = 1.0;
//    _btnRightAgainst.titleLabel.layer.borderColor = [UIColor blueColor].CGColor;
//    _btnRightAgainst.titleLabel.layer.borderWidth = 1.0;
    
    // test1：只设置标题左边距为16pt，titleLabel维持原有中心，标题实际向右偏移8pt，左侧留空8pt
    // [_btnRightAgainst setTitleEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 0)];
    // test2：只设置图标右边距为16pt，imageView维持原有中心，图标实际向左偏移8pt，右侧留空8pt
    // [_btnRightAgainst setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 16)];
    // test3：同时设置标题左边距和图标右边距为8pt，titleLabel/imageView维持原有中心：
    //        图标向左偏移4pt，右侧留空4pt；标题向右偏移4pt，左侧留空4pt。
    //        图标右侧留空+标题左侧留空=8pt间距。
    // [_btnRightAgainst setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    // [_btnRightAgainst setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
    // test4：实现左文字右图标
    CGRect rightBtnTileRect = [rightBtnTile boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                      attributes:@{NSFontAttributeName:titleFont}
                                                         context:nil];
    CGFloat rightBtnImageWidth = rightNorImg.size.width;
    CGFloat rightBtnTitleWidth = CGRectGetWidth(rightBtnTileRect);
    // test41：标题只设置左边距为负图标宽度（24pt），titleLabel维持原有中心，标题实际左移半图标
    // [_btnRightAgainst setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtnImageWidth, 0, 0)];
    // test42：标题只设置右边距为图标宽度（24pt），titleLabel维持原有中心，标题实际左移半图标
    // [_btnRightAgainst setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, rightBtnImageWidth)];
    // test43：test41+test42，titleLabel维持原有中心，标题实际左移图标宽度
    // [_btnRightAgainst setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtnImageWidth, 0, rightBtnImageWidth)];
    //         图标设置左边距为按钮标题宽度，右边距为负按钮标题宽度，imageView维持原有中心，图标实际右移按钮标题宽度
    // [_btnRightAgainst setImageEdgeInsets:UIEdgeInsetsMake(0, rightBtnTitleWidth, 0, -rightBtnTitleWidth)];
    // test44：基于test43，标题继续左移4pt
    [_btnRightAgainst setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtnImageWidth-4, 0, rightBtnImageWidth+4)];
    //         图标继续右移4pt，左侧标题和右侧图标间距8pt
    [_btnRightAgainst setImageEdgeInsets:UIEdgeInsetsMake(0, rightBtnTitleWidth+4, 0, -rightBtnTitleWidth-4)];
    
    /// 默认选中左胶囊【赞同】
    _btnLeftAgree.selected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLeftBtnClick:(id)sender {
    _btnLeftAgree.selected = YES;
    _btnRightAgainst.selected = NO;
}

- (IBAction)onRightBtnClick:(id)sender {
    _btnLeftAgree.selected = NO;
    _btnRightAgainst.selected = YES;
}
@end
