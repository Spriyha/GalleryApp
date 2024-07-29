import CoreData

class CoreDataHelper {
    static let shared = CoreDataHelper()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel") // Ensure this matches your .xcdatamodeld file name
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Context successfully saved.")
            } catch {
                let nserror = error as NSError
                print("Save context failed: \(nserror.localizedDescription)")
            }
        }
    }
    
    func saveImage(id: UUID, url: String, imageData: Data) {
        let imageEntity = ImageEntity(context: context)
        imageEntity.id = id
        imageEntity.url = url
        imageEntity.imageData = imageData
        saveContext()
    }
    
    func fetchImages() -> [ImageEntity]? {
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        do {
            let images = try context.fetch(fetchRequest)
            print("Fetched \(images.count) images from Core Data.")
            return images
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteImage(id: UUID) {
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let images = try context.fetch(fetchRequest)
            for image in images {
                context.delete(image)
            }
            saveContext()
            print("Deleted images with ID: \(id)")
        } catch {
            print("Delete failed: \(error.localizedDescription)")
        }
    }
}
