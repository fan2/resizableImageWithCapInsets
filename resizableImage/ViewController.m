//
//  ViewController.m
//  resizableImage
//
//  Created by faner on 15/9/3.
//  Copyright © 2015年 faner. All rights reserved.
//

#import "ViewController.h"
#import "UIImage_UIColor.h"

// 纵向ImageView圆角半径为6pixel=3point
#define IMGVIEW_CORNER_RADIUS               3   // >=
// top_half_bg@2x.png拉伸矩形区域
#define TOP_IMGVIEW_CAPINSETS               UIEdgeInsetsMake(IMGVIEW_CORNER_RADIUS,IMGVIEW_CORNER_RADIUS,\
                                                                0,IMGVIEW_CORNER_RADIUS)
// bot_half_bg@2x.png拉伸矩形区域
#define BOT_IMGVIEW_CAPINSETS               UIEdgeInsetsMake(0,IMGVIEW_CORNER_RADIUS,\
                                                                IMGVIEW_CORNER_RADIUS,IMGVIEW_CORNER_RADIUS)

// 登录按钮圆角半径为10pixel=5pt
#define LOGIN_BUTTON_CORNER_RADIUS          5   // >=
// 上下左右各保留7pt，scale/resize the interior area through tile or stretch
#define LOGIN_BTN_CAPINSETS                 UIEdgeInsetsMake(LOGIN_BUTTON_CORNER_RADIUS,LOGIN_BUTTON_CORNER_RADIUS,\
                                                                LOGIN_BUTTON_CORNER_RADIUS,LOGIN_BUTTON_CORNER_RADIUS)

// 聊天气泡
#define BUBBLE_ANGLE_SIDE_MARGIN            11  // 尖角侧宽
#define BUBBLE_CORNER_RADIUS                4   // 另3侧圆角半径

// 胶囊按钮字体
#define CAPSULE_ROUNDED_BUTTON_FONT         [UIFont systemFontOfSize:15]
// 胶囊按钮贴图圆角半径为40pixel=20pt
#define BARBTN_CORNER_RADIUS                20
// 椭圆背景宽度
#define BARBTN_BGIMG_WIDTH                  25
// 左边胶囊拉伸矩形区域，保留左椭圆及右边框（上下各保留1pt），竖向窄带拉伸
#define LEFT_BARBTN_CAPINSETS               UIEdgeInsetsMake(1,BARBTN_CORNER_RADIUS,\
                                                                1,1) // 1pt竖向窄带拉伸:right=BARBTN_BGIMG_WIDTH-BARBTN_CORNER_RADIUS-1
// 右边胶囊拉伸矩形区域，保留右椭圆及左边框（上下各保留2pt），1pt竖向窄带拉伸
#define RIGHT_BARBTN_CAPINSETS              UIEdgeInsetsMake(1,BARBTN_BGIMG_WIDTH-BARBTN_CORNER_RADIUS-1,\
                                                                1,BARBTN_CORNER_RADIUS)



@interface ViewController ()

@end

@implementation ViewController

- (void) testVerticalResizable
{
    // UIImageView's default contentMode is UIViewContentModeScaleToFill if the image is not resizable
    /// 上半部背景
    UIImage* topBgImage = [UIImage imageNamed:@"top_half_bg.png"];
    NSLog(@"topBgImage.resizingMode=%zd, topBgImage.capInsets=%@.",
          topBgImage.resizingMode, // 默认为UIImageResizingModeTile
          NSStringFromUIEdgeInsets(topBgImage.capInsets)); // 默认为UIEdgeInsetsZero
    
    // 方式1：stretching中心点
    // stretching the is 1 x 1 pixel region, provides the fastest performance.
    // RESIZABLE_IMAGE_BY_STRETCHING_CENTER_PIXEL(topBgImage);
    topBgImage = [topBgImage resizableImageWithCapInsets:CENTER_PIXEL_CAPINSETS_OF_IMAGE(topBgImage) /*resizingMode:UIImageResizingModeTile*/]; // 默认Stretch，可测试Tile
    // 方式2：tiling顶部椭圆下的围封矩形部分：
    // topBgImage = [topBgImage resizableImageWithCapInsets:TOP_IMGVIEW_CAPINSETS /*resizingMode:UIImageResizingModeStretch*/]; // 默认Tile，可测试Stretch
    _topImgView.image = topBgImage;
    
    /// 下半部背景
    UIImage* botBgImage = [UIImage imageNamed:@"bot_half_bg.png"];
    // 方式1：stretching中心点
    // stretching the is 1 x 1 pixel region, provides the fastest performance.
    // RESIZABLE_IMAGE_BY_STRETCHING_CENTER_PIXEL(botBgImage);
    // 方式2：tiling底部椭圆上的围封矩形部分：
    botBgImage = [botBgImage resizableImageWithCapInsets:BOT_IMGVIEW_CAPINSETS /*resizingMode:UIImageResizingModeStretch*/]; // 默认Tile，可测试Stretch
    _botImgView.image = botBgImage;
}

// 将按钮的type从System修改为Custom，否则默认按下tintColor为蓝色！
// UIButton无法指定多态backgroundColor
- (void) testRoundedRectButton
{
    // （1）背景贴图
#if 0
    UIImage* loginBtnBgImg = [UIImage imageNamed:@"login_btn_bg.tiff"];
    // 方式1：stretching中心点
    // stretching the is 1 x 1 pixel region, provides the fastest performance.
    // loginBtnBgImg = [loginBtnBgImg resizableImageWithCapInsets:CENTER_PIXEL_CAPINSETS_OF_IMAGE(loginBtnBgImg) /*resizingMode:UIImageResizingModeTile*/]; // 默认Stretch，可测试Tile
    RESIZABLE_IMAGE_BY_STRETCHING_CENTER_PIXEL(loginBtnBgImg);
    // 方式2：stretching椭圆中间围封的矩形部分：
    // stretching the interior area not covered by the cap
    // loginBtnBgImg = [loginBtnBgImg resizableImageWithCapInsets:LOGIN_BTN_CAPINSETS resizingMode:UIImageResizingModeStretch]; // 默认Tile，测试Stretch
    /*NSLog(@"loginBtnBg.size=%@, _loginButton.frame=%@",
          NSStringFromCGSize(loginBtnBgImg.size),
          NSStringFromCGRect(_loginButton.frame));*/
    [_loginButton setBackgroundImage:loginBtnBgImg forState:UIControlStateNormal];
#else
    // 除了使用贴图资源外，还可以通过 +[UIImage(UIColor) imageFromColor:] 绘制纯色背景。
    [_loginButton.layer setMasksToBounds:YES];
    [_loginButton.layer setCornerRadius:LOGIN_BUTTON_CORNER_RADIUS];
    [_loginButton setBackgroundImage:[UIImage resizableImageFromColor:RGBCOLOR(54, 187, 72)]
                            forState:UIControlStateNormal];
#endif
    
    // （2）标题，默认titleLabel.textAlignment = NSTextAlignmentCenter
    _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
}

- (void) testResizableBubble
{
    UIFont* msgFont = [UIFont systemFontOfSize:14];
    
    NSString* friendMsg = @"😀今天晚上有空吗，要不要一起去海边兜兜风？";
    _friendMsgLabel.textAlignment = NSTextAlignmentLeft;
    _friendMsgLabel.numberOfLines = 0; //  no limit
    // _friendMsgLabel.lineBreakMode = NSLineBreakByWordWrapping; // default
    _friendMsgLabel.font = msgFont;
    _friendMsgLabel.text = friendMsg;
    UIImage* friendBubbleBgImg = [UIImage imageNamed:@"Chat_Bubble_Friend.tiff"];
    // 方式1：stretching中心点，箭头中心点会被纵向拉伸！
    // friendBubbleBgImg = [friendBubbleBgImg resizableImageWithCapInsets:CENTER_PIXEL_CAPINSETS_OF_IMAGE(friendBubbleBgImg) /*resizingMode:UIImageResizingModeTile*/]; // 默认Stretch，可测试Tile
    // 方式2：tiling中间围封的矩形部分：
    // (4, 11, 4, 4)：默认tile模式下左侧纵向填充出现3个箭头；指定stretch下箭头会沿中心点纵向拉伸钝化。
    // friendBubbleBgImg = [friendBubbleBgImg resizableImageWithCapInsets:UIEdgeInsetsMake(4, 11, 4, 4) /*resizingMode:UIImageResizingModeStretch*/]; // 默认Tile，可测试Stretch
    // (21, 11, 4, 4)：保留箭头所在左上部分，右下方向填充/拉伸。
    friendBubbleBgImg = [friendBubbleBgImg resizableImageWithCapInsets:UIEdgeInsetsMake(21, BUBBLE_ANGLE_SIDE_MARGIN, BUBBLE_CORNER_RADIUS, BUBBLE_CORNER_RADIUS) /*resizingMode:UIImageResizingModeStretch*/]; // 默认Tile，可测试Stretch
    /*NSLog(@"friendBubbleBgImg.size=%@, _friendBubbleImgView.frame=%@",
          NSStringFromCGSize(friendBubbleBgImg.size),
          NSStringFromCGRect(_friendBubbleImgView.frame));*/
    _friendBubbleImgView.image = friendBubbleBgImg;
    
    NSString* replyMsg = @"😘好的。你大概几点过来呢？";
    _myselftMsgLabel.textAlignment = NSTextAlignmentLeft;
    _myselftMsgLabel.numberOfLines = 0;  //  no limit
    // _myselftMsgLabel.lineBreakMode = NSLineBreakByWordWrapping; // default
    _myselftMsgLabel.font = msgFont;
    _myselftMsgLabel.text = replyMsg;
    UIImage* myselfBubbleBgImg = [UIImage imageNamed:@"Chat_Bubble_Myself.tiff"];
    // 保留箭头所在右上部分，左下方向填充/拉伸
    myselfBubbleBgImg = [myselfBubbleBgImg resizableImageWithCapInsets:UIEdgeInsetsMake(21, BUBBLE_CORNER_RADIUS, BUBBLE_CORNER_RADIUS, BUBBLE_ANGLE_SIDE_MARGIN) resizingMode:UIImageResizingModeStretch]; // 默认Tile，测试Stretch
    _myselfBubbleImgView.image = myselfBubbleBgImg;
}

// 默认图标在左侧，标题在右侧，间隔0.5pt（1pixel），整体居中(UIControlContentVerticalAlignmentCenter/UIControlContentHorizontalAlignmentCenter)
- (void) testLeftRoundedButton
{
    ////------------------------------------------------------------------------
    /// 左侧胶囊按钮，constaints固定高度为40pt
    ////------------------------------------------------------------------------
    
    NSString* leftBtnTitle = @"赞同";
    
    // （1）背景
    UIImage* leftNorBgImg = [UIImage imageNamed:@"left_barbtn_bg_normal.png"];
    // stretching中心点
    //  stretching the is 1 x 1 pixel region, provides the fastest performance.
    // RESIZABLE_IMAGE_BY_STRETCHING_CENTER_PIXEL(leftNorBgImg); // 纵向拉伸椭圆圆角部分至顶，导致右侧纵向饱满部分也向上鼓胀。
    // RESIZABLE_IMAGE_BY_INTERIOR_PIXEL(leftNorBgImg, BARBTN_CORNER_RADIUS, BARBTN_CORNER_RADIUS); // 保留左侧椭圆，右侧正确拉伸。但是按下态不正常！
    leftNorBgImg = [leftNorBgImg resizableImageWithCapInsets:LEFT_BARBTN_CAPINSETS /*resizingMode:UIImageResizingModeStretch*/]; // 默认Tile，可测试Stretch
    [_leftAgreeButton setBackgroundImage:leftNorBgImg forState:UIControlStateNormal];
    
    UIImage* leftSelBgImg = [UIImage imageNamed:@"left_barbtn_bg_selected.png"];
    leftSelBgImg = [leftSelBgImg resizableImageWithCapInsets:LEFT_BARBTN_CAPINSETS resizingMode:UIImageResizingModeStretch]; // 默认Tile，测试Stretch
    [_leftAgreeButton setBackgroundImage:leftSelBgImg forState:UIControlStateSelected];
    
    // （2）图标（adjustsImageWhenHighlighted），默认UIViewContentModeScaleToFill
    UIImage* leftNorImg =  [UIImage imageNamed:@"left_barbtn_agree_img_normal.tiff"];
    [_leftAgreeButton setImage:leftNorImg forState:UIControlStateNormal];
    UIImage* leftSelImg = [UIImage imageNamed:@"left_barbtn_agree_img_selected.tiff"];
    [_leftAgreeButton setImage:leftSelImg forState:UIControlStateSelected];
    
    // （3）标题，默认titleLabel.textAlignment = NSTextAlignmentCenter
    _leftAgreeButton.titleLabel.font = CAPSULE_ROUNDED_BUTTON_FONT;
    [_leftAgreeButton setTitleColor:RGBCOLOR(0x29, 0xb4, 0xeb) forState:UIControlStateNormal];
    [_leftAgreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_leftAgreeButton setTitle:leftBtnTitle forState:UIControlStateNormal];
    
#if 0 // 为方便测量观察，可为imageView和titleLabel添加边框
    _leftAgreeButton.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
    _leftAgreeButton.imageView.layer.borderWidth = 0.5f;
    _leftAgreeButton.titleLabel.layer.borderColor = [UIColor blueColor].CGColor;
    _leftAgreeButton.titleLabel.layer.borderWidth = 0.5f;
#endif
    
    NSLog(@"_cmd = %@", NSStringFromSelector(_cmd));
    // 执行以下两句（或其中一句），左右效果抵消。
    // [_leftAgreeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    // [_leftAgreeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    
#if 0
    // test1: setImageEdgeInsets
    //          titleLabel.frame不变，imageView.origin.x左移4pt，
    //          imageView右侧与titleLabel间隔4pt（扣除默认的0.5pt）。
    [_leftAgreeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
    NSLog(@"_cmd1 = %@", NSStringFromSelector(_cmd));
#endif
    
#if 0
    // test2: setTitleEdgeInsets
    //          imageView.frame不变，titleLabel.origin.x右移4pt，
    //          titleLabel左侧与imageView间隔4pt（扣除默认的0.5pt）。
    [_leftAgreeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    NSLog(@"_cmd2 = %@", NSStringFromSelector(_cmd));
#endif
    
#if 1
    // test3: setImageEdgeInsets&setTitleEdgeInsets
    //          imageView.origin.x左移4pt，titleLabel.origin.x右移4pt，
    //          imageView右侧与titleLabel左侧间隔8pt（扣除默认的0.5pt）。
    [_leftAgreeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
    [_leftAgreeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    NSLog(@"_cmd3 = %@", NSStringFromSelector(_cmd));
#endif
    
    // 打印控件布局
    NSLog(@"_leftAgreeButton.frame = %@", NSStringFromCGRect(_leftAgreeButton.frame));
    
    NSLog(@"_leftAgreeButton.imageView.frame = %@", NSStringFromCGRect(_leftAgreeButton.imageView.frame));
    NSLog(@"_leftAgreeButton.imageView.leftMargin = %f", CGRectGetMinX(_leftAgreeButton.imageView.frame));
    
    NSLog(@"_leftAgreeButton.titleLabel.frame = %@", NSStringFromCGRect(_leftAgreeButton.titleLabel.frame));
    NSLog(@"_leftAgreeButton.titleLabel.rightMargin = %f", CGRectGetWidth(_leftAgreeButton.frame)-CGRectGetMaxX(_leftAgreeButton.titleLabel.frame));
    
    NSLog(@"margin[imageView,titleLabel] = %f", CGRectGetMinX(_leftAgreeButton.titleLabel.frame)-CGRectGetMaxX(_leftAgreeButton.imageView.frame));
}

// 默认图标在左侧，标题在右侧，间隔0.5pt（1pixel），整体居中(UIControlContentVerticalAlignmentCenter/UIControlContentHorizontalAlignmentCenter)
- (void) testRightRoundedButton
{
    ////------------------------------------------------------------------------
    /// 右侧胶囊按钮，constaints固定高度为40pt
    ////------------------------------------------------------------------------
    
    NSString* rightBtnTitle = @"反对";
    
    // （1）背景
    UIImage* rightNorBgImg = [UIImage imageNamed:@"right_barbtn_bg_normal.png"];
    rightNorBgImg = [rightNorBgImg resizableImageWithCapInsets:RIGHT_BARBTN_CAPINSETS resizingMode:UIImageResizingModeStretch]; // 默认Tile，测试Stretch
    [_rightAgainstButton setBackgroundImage:rightNorBgImg forState:UIControlStateNormal];
    
    UIImage* rightSelBgImg = [UIImage imageNamed:@"right_barbtn_bg_selected.png"];
    rightSelBgImg = [rightSelBgImg resizableImageWithCapInsets:RIGHT_BARBTN_CAPINSETS /*resizingMode:UIImageResizingModeStretch*/]; // 默认Tile，可测试Stretch
    [_rightAgainstButton setBackgroundImage:rightSelBgImg forState:UIControlStateSelected];
    
    // （2）图标（adjustsImageWhenHighlighted），UIViewContentModeScaleToFill
    UIImage* rightNorImg = [UIImage imageNamed:@"left_barbtn_against_img_normal.tiff"];
    [_rightAgainstButton setImage:rightNorImg forState:UIControlStateNormal];
    UIImage* rightSelImg = [UIImage imageNamed:@"left_barbtn_against_img_selected.tiff"];
    [_rightAgainstButton setImage:rightSelImg forState:UIControlStateSelected];
    
    // （3）标题，默认titleLabel.textAlignment = NSTextAlignmentCenter
    _rightAgainstButton.titleLabel.font = CAPSULE_ROUNDED_BUTTON_FONT;
    [_rightAgainstButton setTitleColor:RGBCOLOR(0x29, 0xb4, 0xeb) forState:UIControlStateNormal];
    [_rightAgainstButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_rightAgainstButton setTitle:rightBtnTitle forState:UIControlStateNormal];
    
#if 0 // 为方便测量观察，可为imageView和titleLabel添加边框
    _rightAgainstButton.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
    _rightAgainstButton.imageView.layer.borderWidth = 0.5f;
    _rightAgainstButton.titleLabel.layer.borderColor = [UIColor blueColor].CGColor;
    _rightAgainstButton.titleLabel.layer.borderWidth = 0.5f;
#endif
    
    // （4）实现左文字右图标，间隔8pt
    // 计算标题的准确size
    CGRect rightBtnTitleRect = [rightBtnTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                      attributes:@{NSFontAttributeName:CAPSULE_ROUNDED_BUTTON_FONT}
                                                         context:nil];
    CGFloat rightBtnImageWidth = rightNorImg.size.width;
    CGFloat rightBtnTitleWidth = CGRectGetWidth(rightBtnTitleRect);
    // test41：标题只设置左边距为负图标宽度（24pt），titleLabel左移半图标
    // [_rightAgainstButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtnImageWidth, 0, 0)];
    // test42：标题只设置右边距为图标宽度（24pt），titleLabel左移半图标
    // [_rightAgainstButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, rightBtnImageWidth)];
    // test43：test41+test42，titleLabel实际左移整个图标宽度
    // [_rightAgainstButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtnImageWidth, 0, rightBtnImageWidth)];
    // 图标设置左边距为按钮标题宽度，右边距为负按钮标题宽度，imageView实际右移按钮标题宽度
    // [_rightAgainstButton setImageEdgeInsets:UIEdgeInsetsMake(0, rightBtnTitleWidth, 0, -rightBtnTitleWidth)];
    // test44：基于test43，标题继续左移4pt
    [_rightAgainstButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtnImageWidth-4, 0, rightBtnImageWidth+4)];
    // 图标继续右移4pt，最终左侧标题和右侧图标间距8pt
    [_rightAgainstButton setImageEdgeInsets:UIEdgeInsetsMake(0, rightBtnTitleWidth+4, 0, -rightBtnTitleWidth-4)];
    
    NSLog(@"_cmd = %@", NSStringFromSelector(_cmd));
    
    // 打印控件布局
    NSLog(@"_rightAgainstButton.frame = %@", NSStringFromCGRect(_rightAgainstButton.frame));
    
    NSLog(@"_rightAgainstButton.titleLabel.frame = %@", NSStringFromCGRect(_rightAgainstButton.titleLabel.frame));
    NSLog(@"_rightAgainstButton.titleLabel.leftMargin = %f", CGRectGetMinX(_rightAgainstButton.titleLabel.frame)); // ?
    
    NSLog(@"_rightAgainstButton.imageView.frame = %@", NSStringFromCGRect(_rightAgainstButton.imageView.frame));
    NSLog(@"_rightAgainstButton.imageView.rightMargin = %f", CGRectGetWidth(_rightAgainstButton.frame)-CGRectGetMaxX(_rightAgainstButton.imageView.frame));
    
    NSLog(@"margin[imageView,titleLabel] = %f", CGRectGetMinX(_rightAgainstButton.imageView.frame)-CGRectGetMaxX(_rightAgainstButton.titleLabel.frame));
}

- (void) testCapsuleRoundedButton
{
    [self testLeftRoundedButton];
    [self testRightRoundedButton];
    
    /// 默认选中左胶囊【赞同】
    _leftAgreeButton.selected = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**************************************************************************/
    //// 纵向ImageView贴图示例
    /**************************************************************************/
    [self testVerticalResizable];
    
    /**************************************************************************/
    //// 圆角登录按钮示例
    /**************************************************************************/
    [self testRoundedRectButton];
    
    /**************************************************************************/
    //// 尖角聊天气泡示例
    /**************************************************************************/
    [self testResizableBubble];
    
    /**************************************************************************/
    //// 横向胶囊按钮示例
    /**************************************************************************/
    [self testCapsuleRoundedButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLeftBtnClick:(id)sender {
    _leftAgreeButton.selected = YES;
    _rightAgainstButton.selected = NO;
}

- (IBAction)onRightBtnClick:(id)sender {
    _leftAgreeButton.selected = NO;
    _rightAgainstButton.selected = YES;
}
@end
