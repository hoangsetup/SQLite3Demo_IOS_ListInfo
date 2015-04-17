//
//  EditInfoViewController.h
//  SQLite3Demo_
//
//  Created by Đinh Văn Hoàng on 3/23/15.
//  Copyright (c) 2015 Hoang Dinh Van. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@protocol EditInfoViewControlerDelegate
- (void)editingWasFished;
@end

@interface EditInfoViewController : UIViewController<UITextFieldDelegate>{
    
    __weak IBOutlet UITextField *txtFirstName;
    __weak IBOutlet UITextField *txtLastName;
    __weak IBOutlet UITextField *txtAge;
}
@property(weak, nonatomic) IBOutlet UITableView *tblPeople;
@property(nonatomic, strong) DBManager *dbManager;
@property(nonatomic, strong) id<EditInfoViewControlerDelegate> delegate;
@property(nonatomic) int recordIDToEdit;

- (IBAction)saveInfo:(id)sender;
- (void)loadInfoToEdit;



@end
