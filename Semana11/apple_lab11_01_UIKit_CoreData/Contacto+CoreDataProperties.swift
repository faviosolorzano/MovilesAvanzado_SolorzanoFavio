//
//  Contacto+CoreDataProperties.swift
//  apple_lab11_01_UIKit_CoreData
//
//  Created by Tecsup on 4/11/26.
//
//

public import Foundation
public import CoreData


public typealias ContactoCoreDataPropertiesSet = NSSet

extension Contacto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacto> {
        return NSFetchRequest<Contacto>(entityName: "Contacto")
    }

    @NSManaged public var nombre: String?
    @NSManaged public var telefono: String?
    @NSManaged public var direccion: String?

}

extension Contacto : Identifiable {

}
