//
//  UserDAO+CoreDataProperties.swift
//  BANews
//
//  Created by Dominik Buraczewski on 24/11/2021.
//
//

import Foundation
import CoreData


extension UserDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDAO> {
        return NSFetchRequest<UserDAO>(entityName: "UserDAO")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var companyName: String?
    @NSManaged public var suiteAddress: String?
    @NSManaged public var zipcodeAddress: String?
    @NSManaged public var cityAddress: String?
    @NSManaged public var streetAddress: String?

}

extension UserDAO : Identifiable {

}
