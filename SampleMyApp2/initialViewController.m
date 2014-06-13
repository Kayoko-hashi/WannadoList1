//
//  initialViewController.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/28.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "initialViewController.h"

@interface initialViewController (){

    UILabel *label;

}

@end

@implementation initialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.BirthDayPicker.datePickerMode = UIDatePickerModeDate;
    self.BirthDayPicker.maximumDate = [NSDate date];
   
    //self.BirthDayPicker.alpha = 0.0;
    //self.doneBtn.alpha = 0.0;
    //self.myLabel.alpha = 0.0;
    //self.doneBtn.titleLabel.font = [UIFont fontWithName:@"Futura" size:20];
    //self.doneBtn.tintColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0];

    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"protDesign-08.png"]];
    
    //説明が表示されるラベル
    [self CreateLabel];
    
    //[self animation];
    
}


-(void)CreateLabel{
    //重なるViewの大きさや色を指定
    //以下のコードで高さや幅を画面の通りにとれる
    

    label = [[UILabel alloc]init];
    label.frame = CGRectMake(80, 500, 20, 40);
    //label.alpha = 0.0;
    label.text = @"生年月日を入力してください。";
    
    //viewが隠れた状態でviewに追加
    [self.view addSubview:label];
    
}

//pickerをアニメーションで表示させる。
- (void)animation{
	// ピッカーが下から出るアニメーション]

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:1.0];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationDelegate:self];
    self.BirthDayPicker.alpha =1.0;
    self.doneBtn.alpha = 1.0;
    self.myLabel.alpha = 1.0;
    [UIView commitAnimations];
	   
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//ピッカーが選択されたときのメソッド
- (IBAction)ChangeDate:(id)sender {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    //日付のフォーマット指定
    df.dateFormat = @"yyyy/MM/dd";
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMdd"];
    
    //現在の日付を取得
    NSDate *CurrentDate = [NSDate date];
    
    //date型をstring型にしてint型に。
    int date1 = [[formatter stringFromDate:CurrentDate] intValue];
    int date2 = [[formatter stringFromDate:self.BirthDayPicker.date] intValue];
    
    //(指定日付-生年月日)/10000 ※floor()で切り捨て処理　年齢の計算式！
    int age = floor((date1 - date2)/10000);
    
    //ラベルに年齢を表示
    label.text = [NSString stringWithFormat:@"%d",age];
    
    //ユーザーでフォルトにユーザーの年齢ageを保存
        _ud = [NSUserDefaults standardUserDefaults];
    
        [_ud setInteger:age forKey:@"age"];
         NSLog(@"%@",_ud);
    
}




- (IBAction)TapDone:(id)sender {
    
    
    UIAlertView *alert=[[UIAlertView alloc]
                        
                        initWithTitle:@"この処理はやり直せません。"
                        message:@"本当にこの誕生日で大丈夫ですか？"
                        delegate:self
                        cancelButtonTitle:@"Cancel"
                        otherButtonTitles:@"OK", nil];
    
    alert.delegate = self;
    
    [alert show];
    
}

// アラートのボタンが押された時に呼ばれるデリゲート例文
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //１番目のボタンが押されたときの処理を記述する
            break;
            
        case 1:
            
            [self dismissViewControllerAnimated:YES completion:nil];

            break;
    }


    
   

}
@end
