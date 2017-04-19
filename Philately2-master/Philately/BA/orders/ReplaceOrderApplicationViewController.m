//
//  ReplaceOrderApplicationViewController.m
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "ReplaceOrderApplicationViewController.h"
#import "ReplaceOrderViewController.h"

#import "SignServiceEntity.h"
#import "SqlQuerySignService.h"
#import "ProductItem.h"

#import "BasicClass.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface ReplaceOrderApplicationViewController ()

@end

@implementation ReplaceOrderApplicationViewController
@synthesize orderNo;
@synthesize resultData;



int picnum;//上传成功图片量
static float scalevale =0.0; //图片压缩比例

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tfreason.delegate=self;
    
    imgarr=[NSMutableArray array];
    dataList =[NSMutableArray array];
    replaceList =[NSMutableArray array];
    picurllist=[NSMutableArray array];
    [self initData];
    
    self.addImgview.userInteractionEnabled =YES;
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self.addImgview addGestureRecognizer:tap];

    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview)]];
    
    SqlQuerySignService* signservice =[[SqlQuerySignService alloc]init];
    scalevale = [((SignServiceEntity*)[signservice querySignServiceWithKey:@"GXH_PIC_COMPRESSION"]).serviceValue floatValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)clickview
{
    [self.tfreason resignFirstResponder];
}
#pragma mark -初始化数据
-(void)initData
{
    self.lborderNo.text = orderNo;
    
    [dataList removeAllObjects];
    int merchListNum = [[resultData objectForKey:@"merchListNum"]intValue];
    for (int i =0; i<merchListNum; i++) {
        NSString* merchID =[resultData objectForKey:@"merchID"][i];
        NSString* merchName =[resultData objectForKey:@"merchName"][i];
//        NSString* normsType =[resultData objectForKey:@"normsType"][i];
        NSString* merchNum =[resultData objectForKey:@"merchNum"][i];
        
        ProductItem* product =[[ProductItem alloc]init];
        product.merchName =merchName;
        product.merchID =merchID;
        product.merchNum =merchNum;
        product.isReplace=@"0";//默认为 不换货
        
        NSString* isexist =@"0";//判断商品是否存在
        for (ProductItem* item in dataList) {
            if ([merchID isEqualToString:item.merchID]) {
                isexist=@"1";
            }
        }
        
        if ([isexist isEqualToString:@"1"]) {
            for (ProductItem* item in dataList) {
                if ([merchID isEqualToString:item.merchID]) {
                    int totalnum =[item.merchNum intValue] +[merchNum intValue];
                    item.merchNum =[NSString stringWithFormat:@"%d",totalnum];
                }
            }
        }
        else
        {
            [dataList addObject:product];
        }
    }
    [self initFrame];
    
    SignServiceEntity* signServiceEty = [[SignServiceEntity alloc]init];
    SqlQuerySignService *sqlService =[[SqlQuerySignService alloc]init];
    signServiceEty = [sqlService querySignServiceWithKey:@"EXCHANGEPICDESC"];
    self.lbcontent.text = [NSString stringWithFormat:@"(%@)",signServiceEty.serviceValue];
    
    //图片最大值
    signServiceEty = [sqlService querySignServiceWithKey:@"MAXCHANGEPICNUM"];
    picMaxNum = [signServiceEty.serviceValue intValue];
    //图片最小值
    signServiceEty = [sqlService querySignServiceWithKey:@"MINCHANGEPICNUM"];
    picMinNum = [signServiceEty.serviceValue intValue];
}
#pragma mark -初始化 商品展示 布局
-(void)initFrame
{
    mtarr =[NSMutableArray array];
    for (int i=0; i<dataList.count; i++) {
        ReplaceOrderApplicationCellViewController *appcell = [[ReplaceOrderApplicationCellViewController alloc]init];
        if (i==0) {
            appcell.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, 80);
        }else
        {
            appcell.view.frame=CGRectMake(0, i*(80+2), self.view.bounds.size.width, 80);
        }
        appcell.delegate =self;
        appcell.addReplaceProduct=^(ProductItem* Ety){
            BOOL isExist=false;
            NSLog(@"%lu",(unsigned long)replaceList.count);
            for (int i=0;i<replaceList.count;i++) {
                ProductItem* item = replaceList[i];
                if ([item.merchID isEqualToString:Ety.merchID]) {//判断商品是否在数组中
                    isExist =true;
                }
                if (isExist) {
                    if ([Ety.isReplace isEqualToString:@"0"]) {//不换货，判断商品是否是换货商品，如果是 不换货商品，则在数组中删除
                        [replaceList removeObject:Ety];
                    }
                }
                else
                {
                    if ([Ety.isReplace isEqualToString:@"1"]&&([Ety.merchNum intValue]>0)) {//换货，判断商品是否是换货商品，如果是 换货商品，判断换货数量是否为0，如果不为0，则在添加到数组中
                        [replaceList addObject:Ety];
                    }
                }
            }
            if (!isExist) {
                if ([Ety.isReplace isEqualToString:@"1"]&&([Ety.merchNum intValue]>0)) {//换货，判断商品是否是换货商品，如果是 换货商品，判断数量是否为0，如果不为0，则在添加到数组中
                    [replaceList addObject:Ety];
                }
            }
            NSLog(@"replacelist.count[%lu]",(unsigned long)replaceList.count);
        };
        
        [appcell initData:dataList[i]];
        [mtarr addObject: appcell];
        [self.smallScrollView addSubview:appcell.view];
    }
    self.smallScrollView.contentSize =CGSizeMake(self.view.bounds.size.width,dataList.count*(80+2)+20);
    
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.bigScrollView.frame=CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    self.bigScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.saveView.frame.origin.y+self.saveView.frame.size.height+150);
    NSLog(@"y:%.2f",self.saveView.frame.origin.y);
    NSLog(@"y:%.2f",self.saveView.frame.size.height);
    
}





#pragma mark -增加数量
-(void)upNum:(ProductItem*)Ety
{
    BOOL isExist=false;
    for (int i=0;i<replaceList.count;i++) {
        ProductItem* item = replaceList[i];
        if ([item.merchID isEqualToString:Ety.merchID]) {//判断商品是否在数组中
            isExist =true;
        }
        if (isExist) {
            item.merchNum =Ety.merchNum;
        }
    }
    if (!isExist) {
        if ([Ety.isReplace isEqualToString:@"1"]) {
            [replaceList addObject:Ety];
        }
    }
}
#pragma mark -减少数量
-(void)downNum:(ProductItem*)Ety
{
    BOOL isExist=false;
    for (int i=0;i<replaceList.count;i++) {
        ProductItem* item = replaceList[i];
        if ([item.merchID isEqualToString:Ety.merchID]) {//判断商品是否在数组中
            isExist =true;
        }
        if (isExist) {
            if ([Ety.merchNum intValue]>0) {
                item.merchNum =Ety.merchNum;
            }
            else
            {
                [replaceList removeObject:Ety];
            }
        }
    }
}
#pragma mark -textView 失效方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
       [self.tfreason resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

#pragma mark - 点击事件
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];    
}

- (IBAction)save:(id)sender {
    MsgReturn* msgReturn =[[MsgReturn alloc]init];
    
    if (imgarr.count<picMinNum) {
        NSString* messageInfo =[NSString stringWithFormat:@"图片数量不能小于%d张",picMinNum];
        UIAlertView* alert =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:messageInfo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (self.tfreason.text==nil||[self.tfreason.text isEqualToString:@""]) {
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"申请理由"  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    
    if (replaceList.count<1) {
        NSString* messageInfo =[NSString stringWithFormat:@"请选择需要换货的商品数量必须大于0"];
        UIAlertView* alert =[[UIAlertView alloc]initWithTitle:@"温馨提醒" message:messageInfo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    picnum = 0;
    [self upImgFile:picnum];
    
    
    
}

-(void)commitApplication
{
    NSString * n0046 =@"JY0046";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    
    [para setValue:orderNo forKey:@"linkOrderNo"];
    [para setValue:self.tfreason.text forKey:@"applyReason"];
    [para setValue:[NSString stringWithFormat:@"%lu",(unsigned long)replaceList.count] forKey:@"applyMerchNum"];
    
    NSMutableArray* linkmerchid =[NSMutableArray array];
    NSMutableArray* merchnum =[NSMutableArray array];
    for (int i=0; i<replaceList.count; i++) {
        ProductItem* ety =replaceList[i];
        [linkmerchid addObject:ety.merchID];
        [merchnum addObject:ety.merchNum];
    }
    [para setValue:linkmerchid forKey:@"linkMerchID"];
    [para setValue:merchnum forKey:@"merchNum"];
    
    
//    [para setValue:[NSString stringWithFormat:@"%lu",(unsigned long)imgarr.count] forKey:@"applyPicNum"];
    NSMutableArray* merchpicid =[NSMutableArray array];
    for (int i=0; i<imgarr.count; i++) {
        [merchpicid addObject:picurllist[i]];
    }
    [para setValue:merchpicid forKey:@"merchPicID"];
    
//    [merchpicid addObject:@"121212"];
//    [para setValue:merchpicid forKey:@"merchPicID"];
    [para setValue:[NSString stringWithFormat:@"%lu",(unsigned long)merchpicid.count] forKey:@"applyPicNum"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0046 business:para delegate:self viewController:self];
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    if ([msgReturn.formName isEqual:@"JY0046"]) {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0046 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        NSString * exchanGoodsNo =[returnDataBody objectForKey:@"exchanGoodsNo"];
        
        ReplaceOrderViewController * replaceOrderView =[[ReplaceOrderViewController alloc]init];
        self.hidesBottomBarWhenPushed =YES;
        replaceOrderView.orderNo=orderNo;
        [self.navigationController pushViewController:replaceOrderView animated:YES];
        
        [self clearArr];
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}
#pragma mark -照相功能
-(void)click
{
    [self.tfreason resignFirstResponder];
    UIActionSheet* actionSheet =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"从手机相册获取",@"拍照", nil];
    [actionSheet showInView:self.view];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //打印出字典中的内容
    NSLog(@"get the media info: %@", info);
    
   
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake((self.view.bounds.size.width-300)/2, (self.view.bounds.size.height-300-60)/2, 300, 300) limitScaleRatio:3.0];
        
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"图片保存成功");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开本地相册
            [self LocalPhoto];
            break;
        case 1:  //打开照相机拍照
            [self takePhoto];
            break;
    }
}

//开始拍照
-(void)takePhoto
{
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
        
    }
    
    //获得相机模式下支持的媒体类型
    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    BOOL canTakePicture = NO;
    
    for (NSString* mediaType in availableMediaTypes) {
        if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
            //支持拍照
            canTakePicture = YES;
            break;
        }
    }
    
    //检查是否支持拍照
    if (!canTakePicture) {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
        return;
    }
    
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
        
        UIAlertView* alter =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"此应用没有权限访问你的拍照功能，您可以在设置中启用访问。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alter show];
        return;
    }
    
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];
    //允许用户进行编辑
    imagePickerController.allowsEditing = NO;
    //设置委托对象
    imagePickerController.delegate = self;
    
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:^{}];

    
}

-(bool)checkImg:(UIImage*)srcimg
{
    
    NSData* imgdata =UIImageJPEGRepresentation(srcimg, scalevale);
    if (imgdata ==nil) {
        imgdata =UIImagePNGRepresentation(srcimg);
    }
    
    int imgsize = imgdata.length;
    
    
    NSLog(@"editimgsize[%d]",imgsize);
    //检查图片类型
    bool imgtypeflag = [self imageTypeCheck:imgdata];
    if (!imgtypeflag) {
        return false;
    }
    
    CGFloat tmpimgwidth = srcimg.size.width;
    CGFloat tmpimgheight =srcimg.size.height;
    MsgReturn* msgreturn =[[MsgReturn alloc]init];
    
    SqlQuerySignService* signservice =[[SqlQuerySignService alloc]init];
    NSString* imgmaxsize = ((SignServiceEntity*)[signservice querySignServiceWithKey:@"GXH_PIC_MAXSIZE"]).serviceValue;
    if (imgsize>[imgmaxsize intValue]*1024*1024)
    {
        msgreturn.errorCode =@"9999";
        msgreturn.errorDesc = [NSString stringWithFormat:@"选择的图片不能大于 %@M",imgmaxsize];
        msgreturn.errorType=@"01";
        [PromptError changeShowErrorMsg:msgreturn title:@"温馨提示"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
             }else
             {
             }
         }
         ];
        return false;
    }
    return  true;
}
#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    UIImage* tmpimg = [BasicClass scaleImage:editedImage toSize:CGSizeMake(300, 300)];
    NSData * tmpimgdata =UIImageJPEGRepresentation(tmpimg, scalevale);
    
    CGFloat tmpimgwidthaaa = tmpimg.size.width;
    CGFloat tmpimgheightaaa =tmpimg.size.height;
    int tmpsize =[tmpimgdata length];
    NSLog(@"原图b1[%d]",tmpsize);
    
    UIImage* tmpscrImg =[UIImage imageWithData:tmpimgdata];
    int tmpsize2 =[UIImageJPEGRepresentation(tmpscrImg, scalevale) length];
    CGFloat tmpimgwidthbbb = tmpscrImg.size.width;
    CGFloat tmpimgheightbbb =tmpscrImg.size.height;
    NSLog(@"原图b2[%d]",tmpsize2);
    
    //将该图像保存到媒体库中
    UIImageWriteToSavedPhotosAlbum(tmpimg, self,@selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    
    if ([self checkImg:tmpscrImg]) {
        NSLog(@"图片保存成功.");
        if (imgarr.count<picMaxNum) {
            [imgarr addObject:tmpscrImg];
            [self reloadData];
        }
    }

    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark -图片类型检查
-(bool)imageTypeCheck:(NSData*)imgdata
{
    //图片类型检查开始
    NSString* imgtype =[[BasicClass typeForImageData:imgdata] uppercaseString];
    
    SqlQuerySignService* signservice =[[SqlQuerySignService alloc]init];
    NSString* querystr = [((SignServiceEntity*)[signservice querySignServiceWithKey:@"GXH_PIC_TYPECOMP"]).serviceValue uppercaseString];
    NSArray* typelist =[querystr componentsSeparatedByString:@";"];
    bool typeflag=false;//是否是符合格式的图片
    for (int i=0; i<typelist.count; i++) {
        if ([imgtype isEqual:typelist[i]]) {
            typeflag =true;
            break;
        }
    }
    
    if (!typeflag) {
        MsgReturn* msgreturn =[[MsgReturn alloc]init];
        msgreturn.errorCode =@"9999";
        msgreturn.errorDesc = [NSString stringWithFormat:@"您当前选择的图片类型不符合系统要求，要求的图片格式为:%@",querystr];
        msgreturn.errorType=@"01";
        
        [PromptError changeShowErrorMsg:msgreturn title:@"温馨提示"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
                 
             }else
             {
                 
             }
             return ;
         }
         ];
        return false;
    }
    return true;
    //图片类型检查结束
}


//打开本地相册
-(void)LocalPhoto
{
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 5; //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
    
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
    
}

#pragma mark ELCImagePickerControllerDelegate Methods
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (imgarr.count+info.count>picMaxNum) {
        NSString* mess =[NSString stringWithFormat:@"上传图片不能超过%d张,请重新选择图片",picMaxNum];
        UIAlertView* alert =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:mess delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){

//                UIImage* editedImage=[dict objectForKey:UIImagePickerControllerOriginalImage] ;
                
//                NSData * imgdata =UIImageJPEGRepresentation(image, 1.0);
//                int imgsize = [imgdata length];
//                NSLog(@"原图[%d]",imgsize);
//                int msize =1024*1024;
//                if (imgsize<=msize) {
//                    scalevale =0.2;
//                }
//                else if (imgsize>msize)
//                {
//                    scalevale =0.1;
//                }
//                
//                
//                UIImage* img =[BasicClass scaleImage:image toScale:scalevale];
//                
//                 int tmsize =[UIImageJPEGRepresentation(img, 1.0) length];
//                NSLog(@"原图a[%d]",tmsize);
                
                /////20150913 begin
                
                UIImage* editedImage=[dict objectForKey:UIImagePickerControllerOriginalImage] ;
                UIImage* tmpimg = [BasicClass scaleImage:editedImage toSize:CGSizeMake(300, 300)];
                NSData * tmpimgdata =UIImageJPEGRepresentation(tmpimg, scalevale);
                
                CGFloat tmpimgwidthaaa = tmpimg.size.width;
                CGFloat tmpimgheightaaa =tmpimg.size.height;
                int tmpsize =[tmpimgdata length];
                NSLog(@"原图b3[%d]",tmpsize);
                
                UIImage* tmpscrImg =[UIImage imageWithData:tmpimgdata];
                int tmpsize2 =[UIImageJPEGRepresentation(tmpscrImg, scalevale) length];
                CGFloat tmpimgwidthbbb = tmpscrImg.size.width;
                CGFloat tmpimgheightbbb =tmpscrImg.size.height;
                NSLog(@"原图b4[%d]",tmpsize2);
                
                /////20150913 end
                
                if ([self checkImg:tmpscrImg])
                {
                    NSLog(@"图片保存成功.");
                    [imgarr addObject:tmpscrImg];
                }
                
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }
    }

    
    
    for (int i =0; i<imgarr.count; i++) {
        CGRect rect;
        if (i<3) {
            rect= CGRectMake(92+i*70, 315, 65, 65);
        }
        else
        {
            rect= CGRectMake(92+(i-3)*70, 70+315, 65, 65);
        }
        
        TTImagePickerItem* item =[[TTImagePickerItem alloc]initWithTTAsset:imgarr[i] frame:rect];
        item.delegate =self;
        
        [self.bigScrollView addSubview:item];
    }
    
}
-(void)goDeleteImg:(UIImage *)image
{
    if ([imgarr containsObject:image]) {
        [imgarr removeObject:image];
        [self reloadData];
    }
}
- (void)reloadData
{
    for (UIView *subView in [self.bigScrollView subviews]) {
        if ([subView isKindOfClass:[TTImagePickerItem class]]) {
            [subView removeFromSuperview];
        }
    }
  
    CGRect rect;
    for (int i =0; i<imgarr.count; i++) {
        
        if (i<3) {
            rect= CGRectMake(92+i*70, 315, 65, 65);
        }
        else
        {
            rect= CGRectMake(92+(i-3)*70, 70+315, 65, 65);
        }
        
        
        TTImagePickerItem* item =[[TTImagePickerItem alloc]initWithTTAsset:imgarr[i] frame:rect];
        item.delegate=self;
        [self.bigScrollView addSubview:item];
    }
}


- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark- 上传图片
-(void)upImgFile:(int)picIndex
{
    
    ServiceInvoker *serviceInvoker=[ServiceInvoker sharedInstance];
    [serviceInvoker  setDelegate:self];
    
    SysBaseInfo *sysBaseInfo =[SysBaseInfo sharedInstance];
    NSString* appid=sysBaseInfo.appID;
    
    UIImage* img = imgarr[picIndex];
    NSMutableDictionary* dic =[[NSMutableDictionary alloc]init];
    if (img!=nil) {
        NSData * imgdata =UIImageJPEGRepresentation(img, scalevale);
        if (imgdata==nil) {
            imgdata =UIImagePNGRepresentation(img);
        }
        
        NSString* imgbyteStr =[imgdata base64Encoding];        
        
        NSString* md5value =[BasicClass md5Digest:imgbyteStr];
        NSString* imgsizevalue =[NSString stringWithFormat:@"%lu",(unsigned long)imgdata.length] ;
        NSLog(@"imgsizevalue[%@]",imgsizevalue);
        
        [dic setValue:[NSString stringWithFormat:@"%@.jpg", orderNo] forKey:@"fileName"];
        [dic setValue:imgsizevalue forKey:@"fileSize"];
        [dic setValue:@"01" forKey:@"fileType"];
        [dic setValue:md5value forKey:@"md5"];
        [dic setValue:@"" forKey:@"uploadPath"];
        [dic setValue:[NSString stringWithFormat:@"%@%@",imgbyteStr,@"f4e69f0c0219f2f3d545cc7ad7d26ae8"]   forKey:@"requestFileData"];
        [serviceInvoker fileUp:appid map:dic ];
        
    }
    
}


//业务请求返回错误
-(void)serviceInvokerError:(MsgReturn*)msgReturn
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    if(msgReturn.formName!=nil && [msgReturn.errorCode isEqualToString:ERROR_FAILED])
    {//交易失败
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0062";//图片上传失败，是否要重试
        [PromptError changeShowErrorMsg:msgReturn title:@"个性化定制"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
                 [self upImgFile:picnum];
             }else
             {
             }
             return ;
         }
         ];
        
    }
    else
    {
        //网络错误 服务器错误  传输格式错误
        if([msgReturn.errorCode isEqualToString:ERROR_DATA_FORMAT_ERROR] || [msgReturn.errorCode isEqualToString:ERROR_SERVICE_IN_ERROR] || [msgReturn.errorCode isEqualToString:ERROR_NOT_NET])
            
        {
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel)
             {
                 if (OKCancel) {
                     
                 }else
                 {
                 }
                 return ;
             }
             ];
            
        }
    }
    
    NSLog(@"%@ %@",msgReturn.formName,msgReturn.errorDesc);
    
}

//业务请求返回数据
-(void)serviceInvokerReturnData:(MsgReturn*)msgReturn
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    
    if([msgReturn.errorCode isEqualToString:ERROR_SUCCESS])
    {//callWebservice成功
        picnum =picnum+1;
        NSString *imageId = [msgReturn.map objectForKey:@"imageId"];
        
        [picurllist addObject:imageId];
        if (picnum == imgarr.count) {//全部图片上传成功
            dispatch_async(dispatch_get_main_queue(), ^{
                [self commitApplication];
            });
            
        }
        else
        {
            [self upImgFile:picnum];
        }
        
    }else{//错误码 非0000
        
        NSLog(@"%@ %@",msgReturn.errorCode,msgReturn.errorDesc);
        [PromptError changeShowErrorMsg:msgReturn title:nil viewController:self block:nil];
    }
    
}

-(void)clearArr
{
    mtarr = nil;
    dataList= nil;//已购买订单商品
    imgarr= nil;//换货上传的图片
    replaceList= nil;//换货商品
    resultData= nil;
    picurllist= nil;
}
@end
