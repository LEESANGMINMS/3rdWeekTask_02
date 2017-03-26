//
//  Article+CoreDataProperties.swift
//  3rdWeek_CollectionViewMemo
//
//  Created by sang minlee on 2017. 3. 26..
//  Copyright © 2017년 LeeSangMin.house. All rights reserved.
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article");
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var image: NSData?

}
