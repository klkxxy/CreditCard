//
//  MXRegUserinfoView.m
//  CatchBear
//
//  Created by 王启颖 on 2018/11/11.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#import "MXRegUserinfoView.h"
#import "MXMainController.h"
#import <ZLPhotoActionSheet.h>
#import <Photos/Photos.h>

@interface MXRegUserinfoView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *headimg_btn;
@property (weak, nonatomic) IBOutlet UITextField *nickname_TF;
@property (weak, nonatomic) IBOutlet UIButton *next_btn;

//图片系统路径
@property (strong, nonatomic) NSString *assetsUrl_Str;
//图片网络路径
@property (strong, nonatomic) NSString *keyUrl_Str;
@property (strong, nonatomic) NSMutableDictionary *dicParams;

@end
@implementation MXRegUserinfoView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initCustomerControls];
}

- (void)initCustomerControls {
    self.next_btn.enabled = NO;
    self.nickname_TF.delegate = self;
    [self.headimg_btn changeCornerRadius:self.headimg_btn.width/2];
    [NSNotificationCenter_defaultCenter addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self dicParams];
}


#pragma mark - 点击事件 -
- (IBAction)nextBtnClick:(UIButton *)sender {
    
    sender.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
    
    if ([self.assetsUrl_Str length] == 0) {
        return;
    }
    
    self.assetsUrl_Str = [self.assetsUrl_Str stringByReplacingOccurrencesOfString:@"file:///" withString:@""];
    
    [MXPublicRequstClass uploadImg:self.assetsUrl_Str success:^(id result) {

        NSLog(@"%@",result);
        self.keyUrl_Str = [NSString stringWithFormat:@"%@%@",Img_URL,result[@"key"]];

        [self updateUserinfoRequest];
    }];
}

- (IBAction)headimgBtnClick:(UIButton *)sender {
    [[self getPas] showPreviewAnimated:YES];
}

#pragma mark - 懒加载 -
//选择照片
- (ZLPhotoActionSheet *)getPas {
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    actionSheet.configuration.allowForceTouch = YES;
    
    //是否可以选择视频
    actionSheet.configuration.allowSelectVideo = NO;
    actionSheet.configuration.allowTakePhotoInLibrary = NO;
    //设置照片最大预览数
    actionSheet.configuration.maxPreviewCount = 20;
    actionSheet.configuration.editAfterSelectThumbnailImage = YES;
    actionSheet.configuration.maxSelectCount = 1;
    actionSheet.configuration.allowEditImage = YES;
    //是否在已选择照片上显示遮罩层
    actionSheet.configuration.showSelectedMask = YES;
    actionSheet.configuration.clipRatios =@[GetClipRatio(1, 1)];
    actionSheet.configuration.showEditTypeClip = YES;
    
    actionSheet.sender = self.viewController;
    
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        
        if (images.count > 0) {
            
            //获取图片路径
            PHAsset *asset = assets[0];
            PHImageManager *manager = [PHImageManager defaultManager];
            [manager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                NSURL *url = [info valueForKey:@"PHImageFileURLKey"];
                self.assetsUrl_Str = [url absoluteString];   //url>string
            }];

            [self.headimg_btn setImage:images[0] forState:UIControlStateNormal];
        }
        
    }];
    
    return actionSheet;
}

- (NSMutableDictionary *)dicParams {
    if (!_dicParams) {
        _dicParams = [NSMutableDictionary dictionary];
    }
    
    return _dicParams;
}
- (void)initdicParams {
    [[MXAccount sharedMXAccount] LoadUserPhoneFromSandbox];
    NSString *user_phone = [MXAccount sharedMXAccount].user_phone;
    
    _dicParams[@"user_phone"] = user_phone;
    _dicParams[@"user_nickname"] = self.nickname_TF.text;
    _dicParams[@"user_headimg"] = self.keyUrl_Str;
}

#pragma mark - 网络请求 -
-(void)updateUserinfoRequest{
    
    [self initdicParams];
    NSLog(@"%@",self.dicParams);
    
    [[MXHttpManagerClass HttpRequstManager] PostURL:updateuser_info params:self.dicParams isHearderparam:YES success:^(NSInteger code, id result) {
        [SVProgressHUD dismiss];
        
        if (code == 0) {
            NSLog(@"%@",result);
            
            MXUserMessage *userMessage = [[MXUserMessage alloc]init];
            [userMessage setUser_phone:_dicParams[@"user_phone"]];
            [userMessage setUser_headimg:_dicParams[@"user_headimg"]];
            [userMessage setUser_nickname:_dicParams[@"user_nickname"]];
            [MXUserMessageTool saveUserMessage:userMessage];
            
            MXMainController * mainTab = [[MXMainController alloc] initWithNibName:nil bundle:nil];
            [UIApplication sharedApplication].keyWindow.rootViewController = mainTab;
            
        }else{
            [SVProgressHUD showImage:NULL_IMAGE status:result[@"message"]];
        }
        
    } fail:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
   
}










#pragma mark - UITextFieldDelegate -
- (void)textFieldDidChange:(NSNotification *)notification {
    if (self.nickname_TF.text.length != 0) {
        self.next_btn.enabled = YES;
        self.next_btn.backgroundColor = MX_BUTTON_COLOR;
    }else {
        self.next_btn.enabled = NO;
        self.next_btn.backgroundColor = MX_BUTTON_Noselect_COLOR;
    }
}

+ (instancetype)initMXRegUserinfoView {
    return NSbunleloadNibName(@"MXRegUserinfoView");
}


@end
