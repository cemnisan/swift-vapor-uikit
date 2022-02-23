import Vapor
import Fluent
import FluentMongoDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // register database
    try app.databases.use(.mongo(connectionString: "mongodb+srv://cameron:753159Cc@gamecluster.mptwk.mongodb.net/myFirstDatabase?retryWrites=true&w=majority"), as: .mongo)
    
    app.migrations.add(CreateList())
    app.logger.logLevel = .debug
    
    try app.autoMigrate().wait()
    
    // register routes
    try routes(app)
}
