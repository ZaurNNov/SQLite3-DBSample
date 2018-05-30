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
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)saveInfo:(UIBarButtonItem *)sender {
    // Prepare the query string.
    NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(null, '%@', '%@', %d)", self.txtFirstname.text, self.txtLastname.text, [self.txtAge.text intValue]];
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
}

@end
