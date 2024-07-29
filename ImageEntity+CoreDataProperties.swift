//
//  ImageEntity+CoreDataProperties.swift
//  
//
//  Created by iPHTech34 on 29/07/24.
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var url: String?
    @NSManaged public var imageData: Data?

}
