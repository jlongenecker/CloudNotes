/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation
import CoreData
import UIKit

class Note : NSManagedObject {
  @NSManaged var title : NSString!
  @NSManaged var body : NSString!
  @NSManaged var dateCreated: NSDate!
  @NSManaged var displayIndex: NSNumber!
  @NSManaged var attachments: NSSet
  
  override func awakeFromInsert() {
    super.awakeFromInsert()
    dateCreated = NSDate()
  }
  
  var image : UIImage? {
    return latestAttachment?.image
  }
  
  var latestAttachment: ImageAttachment? {
    let sortedAttachments = attachments.flatMap { $0 as? ImageAttachment }.sort {
      $0.0.dateCreated.compare($0.1.dateCreated) == .OrderedAscending
    }
    return sortedAttachments.first
  }
}