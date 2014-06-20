//
//  DetailViewController.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/16.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "LeftViewController.h"
#import "ViewController.h"


@interface DetailViewController (){

    UIPickerView *CategoryPicker;
    UIPickerView *limitPicker;
    NSMutableArray *selectCategoryArray;
    NSMutableArray *wannadoListArray;
    NSString *_filepath2;
    NSString *_filepath;
    NSInteger place;
    NSMutableArray *targetAge;
    UITextField *TodoTitleTF;
    UIImageView *BaseImgView;
    UITextView *TodoTitleTV;
    
    int selectedAgeInt;

}

@end

@implementation DetailViewController


//なんだっけ？
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self SelctCategoryPlist];
    [self SelectWannadoPlist];
    
    //カテゴリー用の配列にカテゴリーplistを読み込む
    selectCategoryArray = [[NSMutableArray alloc]init];
    selectCategoryArray = [NSMutableArray arrayWithContentsOfFile:_filepath2];
    self.getArray = [NSMutableArray arrayWithContentsOfFile:_filepath];

    //MainViewでタップされた行数を保存する。
    place = [self PlaceEstimate];
    
    //TODOのタイトルが表示されるテキストフィールドを作る。
    [self CreateTextField];
    
    //limitが表示されるラベル
     self.AgeLable.text = [self.getArray[place] objectForKey:@"Limit"];
    
    //タップされたセルの中身をテキストフィールドに出力
    TodoTitleTF.text =[self.getArray[place] objectForKey:@"TODO"];
    
    //テキストビューの中身
    self.textView.text = [self.getArray[place] objectForKey:@"Memo"];

    //テキストビューのキーボード閉じる
    [self ForCloseKeyboard];
    
    //テキストビューのスタイル
    [self StyleOfTextView];
    
    //詳細設定のための２行のテーブルビューを作る準備。
    [self TableViewSetUp];
    
    //テーブルビューの１行目をタップすると現れるpickerviewをつくる。
    [self CreatePickerView];
    
    //タブバーの設定
    [self StyleOfTabBar];
    
    //設定した年齢から120歳までの数値の配列をつくる。
    [self DurationOfLifeArray];
    
    //アップデリゲートをインスタンス化
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    selectCategoryArray = appdelegate.leftMenuViewContoroller.CategoryArray;
    

    //画像の場所の用意
    //pilistのlimitが初期のときだけ未定の画像を表示
    BaseImgView = [[UIImageView alloc]initWithFrame:CGRectMake(125, 70, 70, 70)];
    [self.view addSubview:BaseImgView];
    //[self.view sendSubviewToBack:BaseImgView];
    [self.view bringSubviewToFront:self.AgeLable];
    
    [self ShowUpAges];
    
}


-(void)viewWillAppear:(BOOL)animated{

    [self SelctCategoryPlist];
    
    selectCategoryArray = [[NSMutableArray alloc]init];
    selectCategoryArray = [NSMutableArray arrayWithContentsOfFile:_filepath2];
    [selectCategoryArray removeObjectAtIndex:0];
    
   


}


//カテゴリーリスト用のパスを準備する。
- (void)SelctCategoryPlist{
    
    //plistのディレクトリを指定
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    //指定されたディレクトリ配下から指定のplist
    _filepath2 = [documentsDirectory stringByAppendingPathComponent:@"Category.plist"];
    
}


- (void)SelectWannadoPlist{
    
    //WannadoList用のパスを作る準備。
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    
    //指定されたディレクトリ配下から指定のplist
    _filepath = [documentsDirectory stringByAppendingPathComponent:@"wannadoList2.plist"];
    
}


-(void)CreateTextField{
    
    TodoTitleTF = [[UITextField alloc]init];
    TodoTitleTF.delegate =self;
    TodoTitleTF.frame = CGRectMake(20, 165, 280, 40);
    TodoTitleTF.font = [UIFont fontWithName:@"Hiragino Kaku Gothic Pro" size:13];
    TodoTitleTF.textColor = [UIColor darkGrayColor];
    [self.view addSubview:TodoTitleTF];
    
    TodoTitleTF.borderStyle = UITextBorderStyleNone;
    
    TodoTitleTF.backgroundColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:0.5];
    TodoTitleTF.textColor = [UIColor darkGrayColor];

    
    //    // 角の丸め
    TodoTitleTF.layer.cornerRadius = 10.0f;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
    paddingView.opaque = NO;
    paddingView.backgroundColor = [UIColor clearColor];
    TodoTitleTF.leftView = paddingView;
    TodoTitleTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pencil-14-14.png"]];
    TodoTitleTF.rightView = icon;
    TodoTitleTF.rightViewMode = UITextFieldViewModeAlways;

}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{

     NSLog(@"Return!!!!!!!!!!");
    
    //元配列の中身を書き換える
    [_getArray[place] setObject:TodoTitleTF.text forKey:@"TODO"];
    [self.getArray writeToFile:_filepath atomically:YES];
  
    //テーブルの再読み込み
    [self.DetailTable reloadData];
    
    //リターンを押したらテキストフィールドが閉じる
    [TodoTitleTF resignFirstResponder];
    return YES;
    
}

-(void)ForCloseKeyboard{


    UIView* accessoryView =[[UIView alloc] initWithFrame:CGRectMake(0,0,320,30)];
    accessoryView.backgroundColor = [UIColor clearColor];
    
    // ボタンを作成する。
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(250,10,70,20);
    [closeButton setTitle:@"Done" forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:20];
    closeButton.tintColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0];
    // ボタンを押したときによばれる動作を設定する。
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    // ボタンをViewに貼る
    [accessoryView addSubview:closeButton];
    
    self.textView.inputAccessoryView = accessoryView;

}


-(void)closeKeyboard:(id)sender{
    
    [self.textView resignFirstResponder];
    
    //元配列の中身を書き換える
    [_getArray[place] setObject:self.textView.text forKey:@"Memo"];
    [self.getArray writeToFile:_filepath atomically:YES];
    
    //テーブルの再読み込み
    [self.DetailTable reloadData];
    
    [self downView];

}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"編集中");
    [self UpView];
    
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 最大入力文字数
    int maxInputLength = 28;
    
    // 入力済みのテキストを取得
    NSMutableString *str = [TodoTitleTF.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:string];
    
    if ([str length] > maxInputLength) {
        // ※ここに文字数制限を超えたことを通知する処理を追加
        
        return NO;
    }
    
    return YES;
}

-(void)StyleOfTextView{

    self.textView.layer.borderWidth = 2;
    self.textView.layer.borderColor = [[UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0]CGColor];
    self.textView.layer.cornerRadius = 8;
    self.textView.delegate = self;
    self.textView.font = [UIFont fontWithName:@"Hiragino Kaku Gothic Pro" size:13];

}

//秀樹大先生が書いてくれたありがたいメソッド！！！
-(NSInteger) PlaceEstimate{
    
    int i = 0;
    int count = 0;
    
    for(NSMutableDictionary* temp in self.getArray){
        
        //もし、LeftViewで選択されたカテゴリーとgetArrayのディクショナリのカテゴリーが一緒だったら
        if ([[temp objectForKey:@"Category"] isEqualToString:self.sikanai_CategoryNamefromLeft]) {
            
            if(i == self.myCount){
                
                return count;
                
            }
            
            i++;
        }
        count++;
    }
    return self.myCount;
    
}


-(void)DurationOfLifeArray{ 
    
    
    targetAge = [[NSMutableArray alloc]init];
    
    
    for ( int i = 0; i<100; i++) {
        
        [targetAge addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    [targetAge insertObject:@"未定" atIndex:0];

}



-(void)StyleOfTabBar{
       self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0];
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.backgroundColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0];

}

#pragma TableView

-(void)TableViewSetUp{

    self.DetailTable.delegate = self;
    self.DetailTable.dataSource = self;
    self.DetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}



//セルに値を返す
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
 
        if (cell == nil){
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
        }
    
        if(indexPath.row == 0){
        
         
            cell.textLabel.text = [self.getArray[place] objectForKey:@"Category"];
            cell.detailTextLabel.text =@"カテゴリー";
       
     
        }
    
        if(indexPath.row == 1){
            
            cell.textLabel.text = [self.getArray[place] objectForKey:@"Limit"];
            cell.detailTextLabel.text =@"予定の年齢";
        
        }
   cell.textLabel.textColor = [UIColor darkGrayColor];
   cell.textLabel.font = [UIFont fontWithName:@"Hiragino Kaku Gothic Pro" size:15];
     return cell;
    
}



//テーブルビューのセルが選択されたときにPickerViewを表示する。
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ( indexPath.row == 0) {
        
        [self showPicker1];
        
    }
    
    if ( indexPath.row == 1) {
       
         [self showPicker2];
    }
    
}
    
#pragma pickerView

//カテゴリー選択用のPickerViewを作る
-(void)CreatePickerView{
    
    [self CreateCategoryPicker];
    [self CreateLimitPicker];
    
}

-(void)CreateCategoryPicker{

    CategoryPicker = [[UIPickerView alloc]
                      initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 200)];
    CategoryPicker.showsSelectionIndicator = YES;
    CategoryPicker.dataSource = self;
    CategoryPicker.delegate = self;
    CategoryPicker.tag = 1;
    
    
    [self.view addSubview:CategoryPicker];
}

-(void)CreateLimitPicker{
    limitPicker = [[UIPickerView alloc]
                   initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 200)];
    limitPicker.showsSelectionIndicator = YES;
    limitPicker.dataSource = self;
    limitPicker.delegate = self;
    limitPicker.tag = 2;
    
    [self.view addSubview:limitPicker];

}

//PickerViewの行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    int componentsNumber = 0;
    
    if (pickerView.tag == 1){
        componentsNumber = selectCategoryArray.count;
    }
    
    if (pickerView.tag == 2) {
        componentsNumber = targetAge.count;
    }
    
    return componentsNumber;

}


//PickerViewの列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;

}


//PickerViewに表示される中身
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *picComponent;
    
    if (pickerView.tag == 1) {
        

        picComponent = [NSString stringWithFormat:@"%@",selectCategoryArray[row]];


    }
    if (pickerView.tag == 2) {
        
     
        picComponent = [NSString stringWithFormat:@"%@",targetAge[row]];
        NSLog(@"%@",targetAge[row]);
        
          }
    
    return  picComponent;

}


//pickerViewの選択完了時に呼ばれる
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //カテゴリーのピッカーが選択されたとき、元配列のkey:Categoryの部分を書き換える
    if (pickerView.tag == 1) {
        
        //元配列の中身を書き換える
        [_getArray[place] setObject:selectCategoryArray[row] forKey:@"Category"];
        
        BOOL result = [self.getArray writeToFile:_filepath atomically:YES];
        if (!result) {
            NSLog(@"ファイルの書き込みに失敗");
        }
        
    }
    
    //年齢のピッカーが選択されたとき、元配列のkey:Categoryの部分を書き換える
    if (pickerView.tag == 2) {
        
        //元配列の中身を書き換える
        [_getArray[place] setObject:[NSString stringWithFormat:@"%@",targetAge[row]] forKey:@"Limit"];
        NSLog(@"%@",targetAge[row]);
        
        [self.getArray writeToFile:_filepath atomically:YES];
        
        [self ShowUpAges];
        
    }
    
       //ピッカービューで選択された年齢をselectedAgeに記憶
    _selectedAge = targetAge[row];
    
    
    [self.DetailTable reloadData];

    
}


-(void)recognizeAge{

    //dvcで選択した年齢を整数型に変換する

    selectedAgeInt = [[self.getArray[place] objectForKey:@"Limit"] intValue];
    NSLog(@"選択された整数＝%d",selectedAgeInt);
  
}



//ラベルに選択された年齢と背景画像を表示する。
-(void)ShowUpAges{

    
    NSLog(@"ああああああああああああああああ%d",selectedAgeInt);
    _selectedAge = [self.getArray[place] objectForKey:@"Limit"];
    
    //もしlimitが設定されていないか、未定が選択された場合。
    if ([_selectedAge isEqualToString:@"未定"] || [_selectedAge isEqualToString:@"いつやるの？"])
    {
        
        BaseImgView.image = [UIImage imageNamed:@"non-13.png"];
        self.AgeLable.hidden = YES;
        

    }else{
        
        BaseImgView.image = [UIImage imageNamed:@"cirX-01.png"];
        self.AgeLable.hidden = NO;
        self.AgeLable.backgroundColor = [UIColor clearColor];
        self.AgeLable.text = [self.getArray[place] objectForKey:@"Limit"];
    }
}


//pickerをアニメーションで表示させる。
- (void)showPicker1 {
	// ピッカーが下から出るアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	CategoryPicker.center = CGPointMake(160,self.view.bounds.size.height-240);
	[UIView commitAnimations];
	
	// 右上にdoneボタン
	if (!self.navigationItem.rightBarButtonItem) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
    }
    
    UIBarButtonItem *CancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
    [self.navigationItem setLeftBarButtonItem:CancelBtn animated:YES];

}

- (void)showPicker2 {
	// ピッカーが下から出るアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	limitPicker.center = CGPointMake(160,self.view.bounds.size.height-200);
	[UIView commitAnimations];
	
	// 右上にdoneボタン
	if (!self.navigationItem.rightBarButtonItem) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
    }
    
    UIBarButtonItem *CancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
    [self.navigationItem setLeftBarButtonItem:CancelBtn animated:YES];
    
}


//pickerをアニメーションで隠す。
- (void)hidePicker {
	// ピッカーが下に隠れるアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	CategoryPicker.center = CGPointMake(160,self.view.bounds.size.height+100);
	[UIView commitAnimations];
    
	// doneボタンを消す
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}

- (void)hidePicker2 {
	// ピッカーが下に隠れるアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDelegate:self];
	limitPicker.center = CGPointMake(160,self.view.bounds.size.height+100);
	[UIView commitAnimations];
    
	// doneボタンを消す
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}


//pickerの編集状態でDONEが押された時。
- (void)done:(id)sender {
	// ピッカーしまう
	[self hidePicker];
    [self hidePicker2];
	
	// doneボタン消す
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    
}

//Pickerの編集状態でキャンセルが押された時。
-(void)Cancel:(id)sender {

    // ピッカーしまう
	[self hidePicker];
    [self hidePicker2];
	
	// doneボタン消す
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    
}


-(void)UpView{
    
    NSInteger up_y = -200;


    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.UpperView.frame = CGRectMake(10, up_y, self.UpperView.bounds.size.width, self.UpperView.bounds.size.height);
    
    self.AgeLable.frame = CGRectMake(135, -40, 70, 77);
    
    self.textView.frame = CGRectMake(15, 105, self.textView.bounds.size.width, self.textView.bounds.size.height);
    
    self.DetailTable.frame = CGRectMake(15, 5, self.DetailTable.bounds.size.width, self.DetailTable.bounds.size.height);
    
    BaseImgView.frame = CGRectMake(125, -40, 70,70);
    
    TodoTitleTF.frame = CGRectMake(15, 5, TodoTitleTF.bounds.size.width, TodoTitleTF.bounds.size.height);

    
    [UIView commitAnimations];


}

-(void)downView{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.UpperView.frame = CGRectMake(0, 0 , self.UpperView.bounds.size.width, self.UpperView.bounds.size.height);
    
    self.AgeLable.frame = CGRectMake(135, 65, 70, 77);
    
    self.textView.frame = CGRectMake(20, 326, self.textView.bounds.size.width, self.textView.bounds.size.height);
    
    self.DetailTable.frame = CGRectMake(15, 220, self.DetailTable.bounds.size.width, self.DetailTable.bounds.size.height);
    
    BaseImgView.frame = CGRectMake(125, 70, 70, 70);
    
    TodoTitleTF.frame = CGRectMake(20, 165, TodoTitleTF.bounds.size.width, TodoTitleTF.bounds.size.height);

    
    
    [UIView commitAnimations];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
