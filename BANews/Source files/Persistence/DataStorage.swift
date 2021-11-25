//
//  DataStorage.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import Foundation
import CoreData

protocol DataStorage: AnyObject {
    func saveUser(_ user: User)
    func savePost(_ post: Post)
    func fetchUser(id: Int, completion: @escaping (User) -> ())
    func fetchPost(id: Int, completion: @escaping (Post) -> ())
    func fetchPosts(completion: @escaping ([FullPost]) -> ())
}

final class DefaultDataStorage: DataStorage {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostsDataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("###\(#function): Failed to load persistent stores:\(error)")
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    private var context: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    
    func saveUser(_ user: User) {
        context.perform {
            let userDAO = UserDAO(context: self.context)
            userDAO.id = Int16(user.id)
            userDAO.name = user.name
            userDAO.phone = user.phone
            userDAO.email = user.email
            userDAO.companyName = user.company.name
            userDAO.cityAddress = user.address.city
            userDAO.suiteAddress = user.address.suite
            userDAO.streetAddress = user.address.street
            userDAO.zipcodeAddress = user.address.zipcode
            userDAO.latitude = user.address.geo.lat
            userDAO.longitude = user.address.geo.lng
                
            self.context.insert(userDAO)
            try? self.context.save()
        }
    }
    
    func savePost(_ post: Post) {
        context.perform {
            let postDAO = PostDAO(context: self.context)
            postDAO.id = Int16(post.id)
            postDAO.userId = Int16(post.userId)
            postDAO.title = post.title
            postDAO.body = post.body
                
            self.context.insert(postDAO)
            try? self.context.save()
        }
    }
    
    func fetchPost(id: Int, completion: @escaping (Post) -> ()) {
        context.perform {
            let request = NSFetchRequest<PostDAO>(entityName: "PostDAO")
            request.predicate = NSPredicate(format: "id == %@", id)
            
            let postDAO = try? self.context.fetch(request).first
            
            let post = Post(
                userId: Int(postDAO?.userId ?? 0),
                id: Int(postDAO?.id ?? 0),
                title: postDAO?.title ?? "",
                body: postDAO?.body ?? ""
            )
            
            completion(post)
        }
    }
    
    func fetchUser(id: Int, completion: @escaping (User) -> ()) {
        context.perform {
            let request = NSFetchRequest<UserDAO>(entityName: "UserDAO")
            request.predicate = NSPredicate(format: "id == %@", id)
            
            let userDAO = try? self.context.fetch(request).first
            
            let geo = Geo(
                lat: userDAO?.latitude ?? "",
                lng: userDAO?.longitude ?? ""
            )
            
            let address = Address(
                street: userDAO?.streetAddress ?? "",
                suite: userDAO?.suiteAddress ?? "",
                city: userDAO?.cityAddress ?? "",
                zipcode: userDAO?.zipcodeAddress ?? "",
                geo: geo
            )
            
            let company = Company(
                name: userDAO?.companyName ?? "",
                catchPhrase: "",
                bs: ""
            )
            
            let user = User(
                id: Int(userDAO?.id ?? 0),
                name: userDAO?.name ?? "",
                email: userDAO?.email ?? "",
                address: address,
                phone: userDAO?.phone ?? "",
                website: "",
                company: company
            )
            completion(user)
        }
    }
    
    func fetchPosts(completion: @escaping ([FullPost]) -> ())  {
        context.perform {
            let postsDAO = try? self.context.fetch(PostDAO.fetchRequest() as NSFetchRequest<PostDAO>)
            let usersDAO = try? self.context.fetch(UserDAO.fetchRequest() as NSFetchRequest<UserDAO>)
            
            var fullPosts = [FullPost]()
            
            completion(fullPosts)
        }
    }
}
