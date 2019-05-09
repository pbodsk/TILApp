import Vapor

class CategoriesController: RouteCollection {
    func boot(router: Router) throws {
        let categoriesRoute = router.grouped("api", "categories")
        categoriesRoute.get(use: getAllHandler)
        categoriesRoute.post(Category.self, use: createHandler)
        categoriesRoute.get(Category.parameter, use: getHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Category]> {
        return Category.query(on: req).all()
    }
    
    func createHandler(_ req: Request, category: Category) throws -> Future<Category> {
        return category.save(on: req)
    }
    
    func getHandler(_ req: Request) throws -> Future<Category> {
        return try req.parameters.next(Category.self)
    }
}
