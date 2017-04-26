//
//  BookService.m
//  MVPArchitecturePractice_SimpleCode
//
//  Created by Daniel on 2017/4/20.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "BookService.h"

@implementation BookService

- (void)getBooksWithCompletion:(DoneHandler)done {
    
    NSMutableDictionary *book1 = [self getBookWithBookName:@"Game of Thrones" withAuthor:@"GeorgeR.R.Martin" withISBN:@"11234" withPrice:@"300"];
    NSMutableDictionary *book2 = [self getBookWithBookName:@"Harry Potter" withAuthor:@"J.K.Rowling" withISBN:@"53463" withPrice:@"400"];
    NSMutableDictionary *book3 = [self getBookWithBookName:@"The Lord of the Rings" withAuthor:@"J.R.R.Tolkien " withISBN:@"939" withPrice:@"250"];
    
    NSArray *books = @[book1,book2,book3];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        done(true,books);
    });
}

- (NSMutableDictionary*)getBookWithBookName:(NSString*)bookName withAuthor:(NSString*)author withISBN:(NSString*)isbn withPrice:(NSString*)price {
    
    NSMutableDictionary *bookInfo = [NSMutableDictionary new];
    [bookInfo setValue:bookName forKey:BOOK_NAME];
    [bookInfo setValue:author forKey:AUTHOR];
    [bookInfo setValue:isbn forKey:ISBN];
    [bookInfo setValue:price forKey:PRICE];
    
    return bookInfo;
}

@end
