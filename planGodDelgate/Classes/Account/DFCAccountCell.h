//
//  DFCAccountCell.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculateFileSize.h"
@interface DFCAccountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *caCheFile;
-(void)tableView:(UITableView *)tableView cell:(DFCAccountCell *)cell indexPath:(NSIndexPath *)indexPath arraySource:(NSArray*)arraySource;
@end
