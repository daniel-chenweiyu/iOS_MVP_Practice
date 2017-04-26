//
//  BookViewController.m
//  MVPArchitecturePractice_SimpleCode
//
//  Created by Daniel on 2017/4/20.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "BookViewController.h"
#import "BookPresenter.h"

@interface BookViewController () <BookViewDelegate,UITableViewDataSource,UITableViewDelegate> {
    BookPresenter *bookPresenter;
    NSMutableArray *booksToDisplay;
    NSMutableDictionary * bookInfo;
}

@end

@implementation BookViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.delegate = self;
    bookPresenter = [BookPresenter new];
    //以下方法皆可讓 bookPresenter delegate 設成 BookViewController
    [bookPresenter attachView:self];
//    bookPresenter.delegate = self;
//    [bookPresenter setDelegate:self];
    [bookPresenter getBooks];
    bookInfo = [NSMutableDictionary new];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return booksToDisplay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    bookInfo = booksToDisplay[indexPath.row];
    cell.textLabel.text = [bookInfo valueForKey:BOOK_NAME];
    cell.detailTextLabel.text = [bookInfo valueForKey:PRICE];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    bookInfo = booksToDisplay[indexPath.row];
    
    UIAlertController *editAlert = [UIAlertController alertControllerWithTitle:@"資料更改" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"書名";
        textField.text = [bookInfo valueForKey:BOOK_NAME];
    }];
    [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"書價";
        textField.text = [bookInfo valueForKey:PRICE];
    }];
    UIAlertAction *editSend = [UIAlertAction actionWithTitle:@"Send" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [bookInfo setObject:editAlert.textFields.firstObject.text forKey:BOOK_NAME];
        [bookInfo setObject:editAlert.textFields.lastObject.text forKey:PRICE];
        booksToDisplay[indexPath.row] = bookInfo;
        [bookPresenter chagneBookInfo:booksToDisplay];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    UIAlertAction *editCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [editAlert addAction:editCancel];
    [editAlert addAction:editSend];
    [self presentViewController:editAlert animated:true completion:nil];
}

#pragma  mark - BookPresenterDelegate
- (void)startLoadingWithPresent:(BookPresenter *)present {
    
    [_activityIndicator startAnimating];
    [_tableView setHidden:true];
    [_emptyView setHidden:false];
}

- (void)finishLoadingWithPresent:(BookPresenter *)present {
    
    [_activityIndicator stopAnimating];
    [_tableView setHidden:false];
    [_emptyView setHidden:true];
    [_activityIndicator setHidden:true];
}

- (void)setBooksWithPresent:(BookPresenter *)present withArray:(NSMutableArray *)books {
    
    booksToDisplay = books;
    [_tableView reloadData];
}

- (void)setEmptyBooksWithPresent:(BookPresenter *)present {
    
    [_tableView setHidden:true];
    [_emptyView setHidden:false];
}

@end


