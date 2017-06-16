//
//  Download.h
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/6.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Download <NSObject>
//自定义KB转换MB
- (id)transformedValue:(id)value{
    
    double convertedValue = [value doubleValue];
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",@“PB”, @“EB”, @“ZB”, @“YB”,nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}
@end
