//
//  ImageView.h
//  DVDataBindDemo
//
//  Created by mlgPro on 2020/3/17.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *btnChangeImage;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeNil;


@end

NS_ASSUME_NONNULL_END
