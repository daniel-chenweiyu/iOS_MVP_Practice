//
//  BookService.m
//  MVPArchitecturePractice_SimpleCode
//
//  Created by Daniel on 2017/4/20.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "BookService.h"
#import "Book.h"

@implementation BookService
- (void)getBooksWithCompletion:(DoneHandler)done {
    
    Book *book1 = [self getBookWithBookName:@"Game of Thrones" withAuthor:@"GeorgeR.R.Martin" withISBN:@"11234" withPrice:300];
    Book *book2 = [self getBookWithBookName:@"Harry Potter" withAuthor:@"J.K.Rowling" withISBN:@"53463" withPrice:400];
    Book *book3 = [self getBookWithBookName:@"The Lord of the Rings" withAuthor:@"J.R.R.Tolkien " withISBN:@"939" withPrice:250];
    
    NSArray *books = @[book1,book2,book3];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        done(true,books);
    });
}
- (Book*)getBookWithBookName:(NSString*)bookName withAuthor:(NSString*)author withISBN:(NSString*)isbn withPrice:(int)price {
    
    Book * bookInfo = [Book new];
    bookInfo.bookName = bookName;
    bookInfo.author = author;
    bookInfo.isbn = isbn;
    bookInfo.price = price;
    
    return bookInfo;
}
@end
