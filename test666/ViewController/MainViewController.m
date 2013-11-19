//
//  MainViewController.m
//  test666
//
//  Created by MacPro01 on 2013/11/05.
//  Copyright (c) 2013年 eyoneya. All rights reserved.
//

#import "MainViewController.h"
#import "EntTableA.h"

@interface MainViewController ()
@end

@implementation MainViewController

@synthesize tfKey;
@synthesize tfTData;
@synthesize tfIData;
@synthesize tfBData;

@synthesize buttonSearch;
@synthesize buttonRegistry;
@synthesize buttonDelete;

- (IBAction)closeSoftwareKeyboard:(id)sender{
    [sender resignFirstResponder];
}

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
    /*
    /// DBを使う準備
    // - DBファイルのパス
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbPathStr = [path objectAtIndex:0];
    // -- DBファイルのパスにDBファイル名を追加する
    FMDatabase *db = [FMDatabase databaseWithPath:[dbPathStr stringByAppendingPathComponent:@"test666.sqlite"]];
*/

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// 登録ボタン押下処理
- (IBAction)InsertData:(id)sender {
    
    // 入力チェック
    if (tfKey.text.length == 0 || tfTData.text.length == 0 || tfIData.text.length == 0 || tfBData.text.length == 0){
        
        // 警告メッセージを表示
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"ダメですよ！" message:@"空欄があってはいけません" delegate:self cancelButtonTitle:@"入力に戻る" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /// DBを使う準備
    // - DBファイルのパス
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoy = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectoy stringByAppendingPathComponent:@"test666.sqlite"];
    // 存在チェック
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    // なかったら
    NSError *error;
    if (!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"test666.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
    }
    if (!success){
        NSAssert1(0, @"failed to create writable db file with message '%@'.", [error localizedDescription]);
        return;
    }
    // - DBファイルのパスにDBファイル名を追加する
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    // - DB開きます
    if (![db open]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    // "db" を再利用するステートメントに設定
    [db setShouldCacheStatements:YES];
    
    //　画面の要素をDB登録
//    NSString *sqlInsert = @"INSERT or REPLACE INTO tableA (key, textData, intData, boolData) VALUES (?, ?, ?, ?)";
    NSString *sqlInsert = @"INSERT INTO tableA (key, textData, intData, boolData) VALUES (?, ?, ?, ?)";
    NSNumber *nsnKey = [NSNumber numberWithInteger:[tfKey.text integerValue]];
    NSString *nsstData = tfTData.text;
    NSNumber *nsniData = [NSNumber numberWithInteger:[tfIData.text integerValue]];
    NSNumber *nsnbData = [NSNumber numberWithBool:[tfBData.text boolValue]];;
    if (![db executeUpdate:sqlInsert,
          nsnKey, nsstData, nsniData, nsnbData]){
        
        // エラー時は、警告メッセージを表示
        NSString *alertMessage = [NSString stringWithFormat:@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]];
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"失敗しました" message:alertMessage delegate:self cancelButtonTitle:@"O K !" otherButtonTitles:nil];
        [alert show];
        
    } else {
        NSString *alertMessage = [NSString stringWithFormat:@"[%ld：%@]を登録しました", [tfKey.text integerValue], tfTData.text];
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"登録しました" message:alertMessage delegate:self cancelButtonTitle:@"ＯＫ！" otherButtonTitles:nil];
        [alert show];
    }
    
    // - DB閉じます
    if (![db close]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    NSLog(@"登録ボタンが押されました。どうするか？");
}

/// 削除ボタン押下処理
- (IBAction)DeleteData:(id)sender {
    
    /// DBを使う準備
    // - DBファイルのパス
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoy = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectoy stringByAppendingPathComponent:@"test666.sqlite"];
    // 存在チェック
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    // なかったら
    NSError *error;
    if (!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"test666.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
    }
    if (!success){
        NSAssert1(0, @"failed to create writable db file with message '%@'.", [error localizedDescription]);
        return;
    }
    // - DBファイルのパスにDBファイル名を追加する
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    // - DB開きます
    if (![db open]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    // "db" を再利用するステートメントに設定
    [db setShouldCacheStatements:YES];

    
    //　TODO 処理を記述
    
    
    // - DB閉じます
    if (![db close]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    NSLog(@"削除ボタンを押しましたね。どうなっても知りませんよ。");
}

/// 検索ボタン押下処理
- (IBAction)SelectData:(id)sender {

    // 検索条件
    // --空だったら処理を抜ける
    NSInteger searchKey = [tfKey.text integerValue];
    if (searchKey < 1){
        NSLog(@"[key]を入力してください。");
        return;
    }
    
    /// DBを使う準備
    // - DBファイルのパス
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectoy = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectoy stringByAppendingPathComponent:@"test666.sqlite"];
    // 存在チェック
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    // なかったら
    NSError *error;
    if (!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"test666.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
    }
    if (!success){
        NSAssert1(0, @"failed to create writable db file with message '%@'.", [error localizedDescription]);
        return;
    }
    // - DBファイルのパスにDBファイル名を追加する
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    // - DB開きます
    if (![db open]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    // "db" を再利用するステートメントに設定
    [db setShouldCacheStatements:YES];
    
    NSString *sqlSELECT = @"SELECT * FROM tableA WHERE key = ?";
    
    // レコードセットからリストを作成
    FMResultSet *results = [db executeQuery:sqlSELECT, [NSNumber numberWithInteger:searchKey]];
    if ([results next]){
        
        NSLog(@"%d, %@, %d, %d", [results intForColumn:@"key"],
                                 [results stringForColumn:@"textData"],
                                 [results intForColumn:@"intData"],
                                 [results boolForColumn:@"boolData"]);
        tfKey.text = [NSString stringWithFormat:@"%d",[results intForColumn:@"key"]];
        tfTData.text = [NSString stringWithFormat:@"%@", [results stringForColumn:@"textData"]];
        tfIData.text = [NSString stringWithFormat:@"%d", [results intForColumn:@"intData"]];
        tfBData.text = [NSString stringWithFormat:@"%d", [results boolForColumn:@"boolData"]];
        
    } else {
        
        tfTData.text = @"対象データがありません";
        tfIData.text = @"";
        tfBData.text = @"";
        
    }
    
    /*
     // 以下は複数レコードが返ってきたときのリストを使った処理
    NSMutableArray *listTableA = [[NSMutableArray alloc] initWithCapacity:0];
    while ([results next]) {
        
        EntTableA *entout = [[EntTableA alloc] init];
        entout.key = [results intForColumn:@"key"];
        entout.textData = [results stringForColumn:@"textData"];
        entout.intData = [results intForColumn:@"intData"];
        entout.boolData = [results boolForColumn:@"boolData"];

        [listTableA addObject:entout];
    }
    
    // リストの内容を表示する
    for (EntTableA *ent in listTableA) {
        
        NSLog(@"%d, %@, %d, %d", (int)ent.key, ent.textData, (int)ent.intData, ent.boolData);
        tfKey.text = [NSString stringWithFormat:@"%d", (int)ent.key];
        tfTData.text = [NSString stringWithFormat:@"%@", ent.textData];
        tfIData.text = [NSString stringWithFormat:@"%d", (int)ent.intData];
        tfBData.text = [NSString stringWithFormat:@"%d", ent.boolData];
    }
    */
    
    // - DB閉じます
    if (![db close]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    NSLog(@"検索ボタンを押しましたか。お探しのものは見つかりましたか？");
}
@end
