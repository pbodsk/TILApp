import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    let acronymsController = AcronymsController()
    try router.register(collection: acronymsController)
    
    let userController = UserController()
    try router.register(collection: userController)
    
    let categoryController = CategoryController()
    try router.register(collection: categoryController)
    
    let websiteController = WebsiteController()
    try router.register(collection: websiteController)
}
