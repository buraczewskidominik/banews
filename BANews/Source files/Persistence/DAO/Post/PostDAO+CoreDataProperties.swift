//
//  PostDAO+CoreDataProperties.swift
//  BANews
//
//  Created by Dominik Buraczewski on 24/11/2021.
//
//

import Foundation
import CoreData


extension PostDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostDAO> {
        return NSFetchRequest<PostDAO>(entityName: "PostDAO")
    }

    @NSManaged public var userId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var user: UserDAO?

}

extension PostDAO : Identifiable {

}
