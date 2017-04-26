//
//  BookService.h
//  MVPArchitecturePractice_SimpleCode
//
//  Created by Daniel on 2017/4/20.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BOOK_NAME @"bookName"
#define PRICE @"price"
#define AUTHOR @"author"
#define ISBN @"isbn"

typedef void (^DoneHandler)(bool isSucces,id result);
@interface BookService : NSObject

- (void)getBooksWithCompletion:(DoneHandler)done;

@end
