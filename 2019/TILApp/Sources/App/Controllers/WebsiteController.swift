import Vapor

struct WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
        router.get("acronyms", Acronym.parameter, use: acronymHandler)
        router.get("users", use: allUsersHandler)
        router.get("users", User.parameter, use: userHandler)
        router.get("categories", use: allCategoriesHandler)
        router.get("categories", Category.parameter, use: categoryHandler)
        router.get("acronyms", "create", use: createAcronymHandler)
        router.post(Acronym.self, at: "acronyms", "create", use: createAcronymPostHandler)
    }
    
    func indexHandler(_ req: Request) throws -> Future<View> {
        return Acronym.query(on: req).all().flatMap(to: View.self) { acronyms in
            let context = IndexContext(title: "Homepage", acronyms: acronyms)
            return try req.view().render("index", context)
        }
    }
    
    func acronymHandler(_ req: Request) throws -> Future<View> {
        return try req.parameters.next(Acronym.self).flatMap(to: View.self) { acronym in
            return acronym.user.get(on: req).flatMap(to: View.self) { user in
                let acronymContext = try AcronymContext(title: acronym.short, acronym: acronym, user: user, categories: acronym.categories.query(on: req).all())
                return try req.view().render("acronym", acronymContext)
            }
        }
    }
    
    func userHandler(_ req: Request) throws -> Future<View> {
        return try req.parameters.next(User.self).flatMap(to: View.self) { user in
            let userContext = try UserContext(title: user.name, user: user, acronyms: user.acronyms.query(on: req).all())
            return try req.view().render("user", userContext)
        }
    }
    
    func allUsersHandler(_ req: Request) throws -> Future<View> {
        return User.query(on: req).all().flatMap(to: View.self) { users in
            let allUsersContext = AllUsersContext(users: users)
            return try req.view().render("users", allUsersContext)
        }
    }
    
    func allCategoriesHandler(_ req: Request) throws -> Future<View> {
        return Category.query(on: req).all().flatMap(to: View.self) { categories in
            let allCategoriesContext = AllCategoriesContext(categories: categories)
            return try req.view().render("categories", allCategoriesContext)
        }
    }
    
    func categoryHandler(_ req: Request) throws -> Future<View> {
        return try req.parameters.next(Category.self).flatMap(to: View.self) { category in
            let categoryContext = try CategoryContext(title: category.name, acronyms: category.acronyms.query(on: req).all())
            return try req.view().render("category", categoryContext)
        }
    }
    
    func createAcronymHandler(_ req: Request) throws -> Future<View> {
        let createAcronymContext = CreateAcronymContext(users: User.query(on: req).all())
        return try req.view().render("createAcronym", createAcronymContext)
    }
    
    func createAcronymPostHandler(_ req: Request, acronym: Acronym) throws -> Future<Response> {
        return acronym.save(on: req).map(to: Response.self) { acronym in
            guard let id = acronym.id else {
                return req.redirect(to: "/")
            }
            return req.redirect(to: "/acronyms/\(id)")
        }
    }
}

struct IndexContext: Encodable {
    let title: String
    let acronyms: [Acronym]
}

struct AcronymContext: Encodable {
    let title: String
    let acronym: Acronym
    let user: User
    let categories: Future<[Category]>
}

struct UserContext: Encodable {
    let title: String
    let user: User
    let acronyms: Future<[Acronym]>
}

struct AllUsersContext: Encodable {
    let title = "All Users"
    let users: [User]
}

struct AllCategoriesContext: Encodable {
    let title = "All Categories"
    let categories: [Category]
}

struct CategoryContext: Encodable {
    let title: String
    let acronyms: Future<[Acronym]>
}

struct CreateAcronymContext: Encodable {
    let title = "Create an Acronym"
    let users: Future<[User]>
}
