//
//  ItemList+CoreDataProperties.swift
//  24_CoreDataWithAPI
//
//  Created by Nandhika T M on 12/12/24.
//
//

import Foundation
import CoreData


extension ItemList
{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemList> {
        return NSFetchRequest<ItemList>(entityName: "ItemList")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var sku: String?
    @NSManaged public var item_id: String?
    @NSManaged public var rate: Int64
}

extension ItemList : Identifiable {

}
