//
//  MXColor.h
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/10.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#ifndef MXColor_h
#define MXColor_h

#define MX_MAIN_COLOR [UIColor whiteColor]
#define MX_LINE_COLOR UIColorMake(244,244,244)

#define MX_BLACK_COLOR  [UIColor blackColor]
#define MX_FONTGRAY_COLOR  UIHexColor(@"#999999")//UIColorMake(184,184,184) //字体灰
#define MX_GRAY_COLOR  UIHexColor(@"#F4F4F4")


#define CCOL_BOTTONTAB_COLOR [UIColor whiteColor]
#define MX_BUTTON_COLOR UIHexColor(@"#60888C")
#define MX_BUTTON_Noselect_COLOR UIHexColor(@"#E3E3E3")

#define UIColorMake(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define UIHexColor(name) [UIColor colorFromHexString:name]


#endif /* MXColor_h */
