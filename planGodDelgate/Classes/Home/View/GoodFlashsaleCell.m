//
//  GoodFlashsaleCell.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/26.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "GoodFlashsaleCell.h"
#import "PlanColorDef.h"
#import "PlanConst.h"
@interface GoodFlashsaleCell (){
  dispatch_source_t _timer;
}
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
//@property(nonatomic,strong)UILabel *timerLabel;
@property(nonatomic,copy)NSString*hourLabel;
@property(nonatomic,copy)NSString*minuteLabel;
@property(nonatomic,copy)NSString*secondLabel;
@end

@implementation GoodFlashsaleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goodGes:)];
//    [self.imgUrl addGestureRecognizer:tap];
     [self timerlayer];
     [self tiemerDate];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//-(UILabel*)timerLabel{
//    if (!_timerLabel) {
//
//        _timerLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 0, 150, 27)];
//        _timerLabel.backgroundColor = [UIColor whiteColor];
//        _timerLabel.textAlignment = NSTextAlignmentCenter;
//        _timerLabel.textColor = UIColorFromRGB(SearchTypeColor);
//        _timerLabel.font = [UIFont systemFontOfSize:15];
////        _timerLabel.center = self.center;
//        [self timerlayer];
//        [self tiemerDate];
//        [_imgUrl addSubview:_timerLabel];
//    }
//    return _timerLabel;
//}

-(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
}

-(void)tiemerDate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *endDate = [dateFormatter dateFromString:[self getyyyymmdd]];
    NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate] + 24*3600)];
    NSDate *startDate = [NSDate date];
    NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
    
    if (_timer==nil) {
        __block int timeout = timeInterval/2; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.hourLabel = @"00";
                        self.minuteLabel = @"00";
                        self.secondLabel = @"00";
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    if (days==0) {
                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (hours<10) {
                            self.hourLabel = [NSString stringWithFormat:@"0%d%@",hours,@":"];
                        }else{
                            self.hourLabel = [NSString stringWithFormat:@"%d%@",hours,@":"];
                        }
                        if (minute<10) {
                            self.minuteLabel = [NSString stringWithFormat:@"0%d%@",minute,@":"];
                        }else{
                            self.minuteLabel = [NSString stringWithFormat:@"%d%@",minute,@":"];
                        }
                        if (second<10) {
                            self.secondLabel = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondLabel = [NSString stringWithFormat:@"%d",second];
                        }
                        _timerLabel.text = [NSString stringWithFormat:@"%@%@%@%@",@"计时抢购中 ",_hourLabel,_minuteLabel,_secondLabel];
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

-(void)timerlayer{
     _timerLabel.layer.cornerRadius=2.5f;
     _timerLabel.layer.masksToBounds=YES;
     _timerLabel.layer.borderColor=[[UIColor whiteColor] CGColor];
     _timerLabel.layer.borderWidth= 0.5f;
}

-(void)gesture:(void(^)(NSString *sender))block{
    block(@"点击事件");
}

-(void)addTapGestureTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self.imgUrl addGestureRecognizer:tap];
}

- (void)goodGes:(UIGestureRecognizer *)sender {
    if (self.goodGesBlock) {
        self.goodGesBlock(sender.view.tag);
    }
}

@end
