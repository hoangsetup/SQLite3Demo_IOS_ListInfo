//
//  EditInfoViewController.m
//  SQLite3Demo_
//
//  Created by Đinh Văn Hoàng on 3/23/15.
//  Copyright (c) 2015 Hoang Dinh Van. All rights reserved.
//

#import "EditInfoViewController.h"

@interface EditInfoViewController ()

@end

@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set the navigation bar tint color.
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    
    // Make self the delegate of the textfields.
    txtAge.delegate = self;
    txtFirstName.delegate = self;
    txtLastName.delegate = self;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"peopleInfo.sqlite3"];
    
    // Check is edit or add
    if(self.recordIDToEdit != -1){
        [self loadInfoToEdit];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveInfo:(id)sender {
    // Prepare the query string.
    NSString *query;
    if(self.recordIDToEdit == -1){
        query = [NSString stringWithFormat:@"insert into tblInfo(firstname, lastname, age) values('%@', '%@', %d)", txtFirstName.text, txtLastName.text, [txtAge.text intValue]];
    }else{
        query = [NSString stringWithFormat:@"update tblInfo set firstname='%@', lastname='%@', age=%d where peopleInfoID=%d", txtFirstName.text, txtLastName.text, [txtAge.text intValue], self.recordIDToEdit];
    }
    
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        [self.delegate editingWasFished];
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    else{
        NSLog(@"Could not execute the query.");
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not insert data!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)loadInfoToEdit{
    // Create query
    NSString *query = [NSString stringWithFormat:@"select * from tblInfo where peopleInfoID=%d", self.recordIDToEdit];
    
    // Load data.
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    txtFirstName.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"firstname"]];
    txtLastName.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lastname"]];
    txtAge.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"age"]];
}

@end
