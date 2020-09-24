//
//  Persistence.swift
//  CoreData
//
//  Created by Benjamin Keys on 9/22/20.
//

import CoreData

struct PersistenceController {
    static var shared: PersistenceController = {
        let result = PersistenceController()
        result.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func loadData(context: NSManagedObjectContext) {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            fatalError("Invalid URL")
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                fatalError(error?.localizedDescription ?? "Unknown Error")
            }
            if let data = data {
                let decoder = JSONDecoder()
                let RFC3339DateFormatter = DateFormatter()
                RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
                RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                RFC3339DateFormatter.timeZone = TimeZone.current
                decoder.dateDecodingStrategy = .formatted(RFC3339DateFormatter)
                decoder.userInfo[CodingUserInfoKey.context!] = context // attach moc to Decoder (to pass into place initializer)
                DispatchQueue.main.async {
                    do {
                        _ = try decoder.decode([User].self, from: data)
                    } catch DecodingError.dataCorrupted(let context) {
                        fatalError("Error decoding Title\n\(context.debugDescription)")
                    } catch DecodingError.keyNotFound(let key, let context) {
                        fatalError("Error decoding Title\n\(key.stringValue) was not found, \(context.debugDescription)")
                    } catch DecodingError.typeMismatch(let type, let context) {
                        fatalError("Error decoding Title\n\(type) was expected, \(context.debugDescription)")
                    } catch DecodingError.valueNotFound(let type, let context) {
                        fatalError("Error decoding Title\nNo value was found for \(type), \(context.debugDescription)")
                    } catch {
                        fatalError("Error decoding Title\nUnknown Error")
                    }
                    if context.hasChanges {
                        do {
                            try context.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                }
            } else {
                fatalError("URL session retrieved no data")
            }
        }.resume()
    }
}
