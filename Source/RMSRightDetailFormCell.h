//
//  RMSRightDetailFormCell.h

//
//  Created by Tony Ingraldi on 10/26/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSDataCell.h"

/*!
 \brief A subclass of RMSDataCell that presents itself with a right-detail label and a disclosure indicator

 RMSRightDetailFormCell is intended for extension. Subclasses typically override respondToSelection
 where a UIViewController would be instantiated as needed. This UIViewController is then passed to
 the cell's delegate for pushing or presentation.
 */
@interface RMSRightDetailFormCell : RMSDataCell

@end
