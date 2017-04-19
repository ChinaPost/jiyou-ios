


#import "OrderFormCancelDetailViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import <objc/runtime.h>
#import "PromptError.h"

@implementation OrderFormCancelDetailViewController


    float touchy1;
    int   movelength1;
    int  keyboardHeight1;
    bool keyboardOpen;
 NSString *tip;


//请选择取消理由
@synthesize titleTextView;
//我不想买了
@synthesize row1TextView;
//选择1
@synthesize check1CheckBox;
//信息填写错误，重新拍
@synthesize row2TextView;
//选择2
@synthesize check2CheckBox;
//卖家缺货
@synthesize row3TextView;
//选择3
@synthesize check3CheckBox;
//其它原因
@synthesize rowOhterTextView;
//选择其它
@synthesize checkOtherCheckBox;
//xin
@synthesize xinImageView;
//请输入取消原因
@synthesize inputDetailEditText;
//取消
@synthesize cacelButton;
//确定
@synthesize sureButton;




- (void)viewDidLoad
{
    [super viewDidLoad];
  

    //我不想买了


    
    [self.check1CheckBox addTarget:self action:@selector(check1CheckBoxCheck:) forControlEvents:UIControlEventTouchUpInside];
  [self.check1 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    
    
    //信息填写错误，重新拍


    
    [self.check2CheckBox addTarget:self action:@selector(check2CheckBoxCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.check2 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
  
    
    
    //卖家缺货
  

    [self.check3CheckBox addTarget:self action:@selector(check3CheckBoxCheck:) forControlEvents:UIControlEventTouchUpInside];

    [self.check3 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    
    
    //其它原因

  
    
    [self.checkOtherCheckBox addTarget:self action:@selector(checkOtherCheckBoxCheck:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.checkother setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    

    self.inputDetailEditText.returnKeyType=UIReturnKeyDone;
    [self.inputDetailEditText addTarget:self action:@selector(inputDetailEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
 
    
    [self.inputDetailEditText addTarget:self action:@selector(inputDetailEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.inputDetailEditText.returnKeyType=UIReturnKeyDone;
    
    
     [self.otherView setHidden:YES];
    
    
    UITapGestureRecognizer *onenumguest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTextTapHandle:)];
    
    onenumguest.delegate = self;
    //onenumguest.cancelsTouchesInView = NO;
    
    [ self.inputDetailEditText  addGestureRecognizer:onenumguest];
    

    
 
    [self.cacelButton addTarget:self action:@selector(cacelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
 
    
    
    [self.sureButton addTarget:self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
 
    
    
     dic=[[NSDictionary alloc] init];
    
    
    
    
    
    
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboardBlankPlaceTapHandle:)];
   
    
    [self.view addGestureRecognizer:closeKeyboardtap];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    

    
}

-(void) viewWillAppear:(BOOL)animated{

}



//编辑框键盘顶起start

//注销键盘监听
-(void)viewDidDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}




- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
    
    
}


//点空白区域键盘消失
-(void)closeKeyboardBlankPlaceTapHandle:(UITapGestureRecognizer *)sender

{
  
    if (keyboardOpen) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
    
}

//touchY 触摸位置
-(void)editTextTapHandle:(UITapGestureRecognizer *)sender

{
    
     if (keyboardOpen) {
         return;
     }
    
    CGPoint point = [sender locationInView:self.view];
    touchy1=point.y+15;
    
    if(keyboardHeight1>0)
    {
        if(touchy1>keyboardHeight1)
        {
            movelength1=touchy1-keyboardHeight1;
            [self MoveView:(-movelength1)];
        }else
        {
            movelength1=0;
            [self MoveView:(-movelength1)];
        }
    }
    

}




//键盘打开监听回调
- (void)keyboardWillShow:(NSNotification *)notification {
    
    
    keyboardOpen=true;
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    float keyboardTop = keyboardRect.origin.y;
    
    
    
    if(keyboardHeight1==0)
    {
        // Get the duration of the animation.
        NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSTimeInterval animationDuration;
        [animationDurationValue getValue:&animationDuration];
        //
        //    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        
        keyboardHeight1=keyboardTop;
        
        if(touchy1>keyboardHeight1)
        {
            movelength1=touchy1-keyboardHeight1;
            [self MoveView:(-movelength1)];
        }else
        {
            movelength1=0;
            [self MoveView:(-movelength1)];
        }
    
    
        
           [UIView commitAnimations];
    }
    
    
 
    
    
}

//键盘关闭监听回调
- (void)keyboardWillHide:(NSNotification *)notification {
    
      keyboardOpen=false;
    NSDictionary* userInfo = [notification userInfo];
    
    
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    
    [self MoveView:(movelength1)];
    
    
    [UIView commitAnimations];
}




-(void)MoveView:(int)h{
    
    
    if (h<0) {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        [UIView setAnimationBeginsFromCurrentState: YES];
        [self.contain setFrame: CGRectMake(self.contain.frame.origin.x, self.contain.frame.origin.y + h, self.contain.frame.size.width, self.contain.frame.size.height)];
       // [UIView commitAnimations];
    }else
    {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        [UIView setAnimationBeginsFromCurrentState: YES];
        [self.contain setFrame: CGRectMake(self.contain.frame.origin.x, self.contain.frame.origin.y+h , self.contain.frame.size.width, self.contain.frame.size.height)];
       // [UIView commitAnimations];
    }
    
    
    
}

//编辑框键盘顶起end




-(void)check1CheckBoxCheck:(UIButton *)btn{
 
  
         [self.check1 setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    
         [self.check2 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
         [self.check3 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
         [self.checkother setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    
    tip=row1TextView.text;
    [self.otherView setHidden:YES];
    
}



-(void)check2CheckBoxCheck:(UIButton *)btn{

    [self.check1 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    
    [self.check2 setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [self.check3 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [self.checkother setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    
    
    tip=row2TextView.text;
      [self.otherView setHidden:YES];
}

-(void)check3CheckBoxCheck:(UIButton *)btn{
    [self.check1 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    
    [self.check2 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [self.check3 setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    [self.checkother setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    
    
    tip=row3TextView.text;
      [self.otherView setHidden:YES];
}

-(void)checkOtherCheckBoxCheck:(UIButton *)btn{
    [self.check1 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    
    [self.check2 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [self.check3 setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [self.checkother setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    
    
    tip=rowOhterTextView.text;
      [self.otherView setHidden:NO];
}


-(void)inputDetailEditTextDidEndOnExit:(UITextField *)textField{
    [self.view becomeFirstResponder];//把焦点给别人 键盘消失
   
    
        tip=textField.text;
}

-(void)inputDetailEditTextDidEnd:(UITextField *)textField{
    [self.view becomeFirstResponder];//把焦点给别人 键盘消失
    
    
     tip=textField.text;
}



-(void)cacelButtonClicked:(UIButton *)btn{
    id mId = objc_getAssociatedObject(btn, "mId");
    //取绑定数据int mId2 = btn.tag;
    //取绑定数据
    [self.view setHidden:YES];
}
    
    -(void)sureButtonClicked:(UIButton *)btn{
        id mId = objc_getAssociatedObject(btn, "mId");
        //取绑定数据int mId2 = btn.tag;
        //取绑定数据
        
        if(tip==nil || [tip isEqualToString:@""] ||( [tip isEqualToString:@"其它原因"] && [inputDetailEditText.text isEqual:@""]))
        {
            
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            
        
                msgReturn.errorCode=@"0001";//不能为空
                [PromptError changeShowErrorMsg:msgReturn title:@"取消理由"  viewController:self block:^(BOOL OKCancel){} ];
            return;
        }
        
        if (( [tip isEqualToString:@"其它原因"] && ![inputDetailEditText.text isEqual:@""])) {
            tip=inputDetailEditText.text;
        }
        
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [arr addObject:tip];
        [self.chirldViewCallBackDelegate chirldViewCallBack:arr ];
        [self.view setHidden:YES];
        
    }
        
        
        -(void) setChirldViewValue:(NSMutableArray*)mdata  delegate:(id<OrderFormCancelDetailChirldViewCallBackDelegate>)parent{
            self.chirldViewCallBackDelegate=parent;
            chirldViewData=mdata;
        }
        
        @end//end viewController
        
