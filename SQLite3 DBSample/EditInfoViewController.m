//
//  EditInfoViewController.m
//  SQLite3 DBSample
//
//  Created by Zaur Giyasov on 30/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "EditInfoViewController.h"
#import "DBManager.h"



@interface EditInfoViewController ()

@property (nonatomic, strong) DBManager *dbManager;
-(void)loadInfoToEdit;

@end

@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    
    // Make self the delegate of the textfields.
    self.txtFirstname.delegate = self;
    self.txtLastname.delegate = self;
    self.txtAge.delegate = self;
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    
    // Check if should load specific record for editing
    if (self.recordIDToEdit != -1) {
        // Load the record from DB
        [self loadInfoToEdit];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)saveInfo:(UIBarButtonItem *)sender {
    // Prepare the query string.
    // If the record ID property has value other than -1
    NSString *query;
    if (self.recordIDToEdit == -1) {
        query = [NSString stringWithFormat:@"insert into peopleInfo values(null, '%@', '%@', %d)",
                 self.txtFirstname.text, self.txtLastname.text, [self.txtAge.text intValue]];
    } else {
        query = [NSString stringWithFormat:@"update peopleInfo set firstname='%@', lastname='%@', age=%d where peopleInfoID=%d",
                 self.txtFirstname.text, self.txtLastname.text, self.txtAge.text.intValue, self.recordIDToEdit];
    }
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished
        [self.selfDelegate editingInfoWasFinished];
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
}

-(void)loadInfoToEdit {
    // Create the query
    NSString *query = [NSString stringWithFormat:@"select *from peopleInfo where peopleInfoID=%d", self.recordIDToEdit];
    
    // Load the relevant data
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Set the loaded data to self UI property
    self.txtFirstname.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"firstname"]];
    self.txtLastname.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"lastname"]];
    self.txtAge.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"age"]];
}



@end
