//
//  DFCAccountCell.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DFCAccountCell.h"

@implementation DFCAccountCell

- (void)awakeFromNib {
    // Initialization code
     [super awakeFromNib];
}

-(void)tableView:(UITableView *)tableView cell:(DFCAccountCell *)cell indexPath:(NSIndexPath *)indexPath arraySource:(NSArray*)arraySource{

    cell.name.text = [arraySource objectAtIndex:indexPath.row];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.imgView.image =[UIImage imageNamed:[NSString stringWithFormat:@"findhome_%ld",(long)indexPath.row]];
    if (indexPath.row==arraySource.count-1) {
        float size = [[CalculateFileSize defaultCalculateFileSize] fileSizeAtPath:@"Library/Caches"];
        _caCheFile.text = [NSString stringWithFormat:@"%.2fM",size];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
