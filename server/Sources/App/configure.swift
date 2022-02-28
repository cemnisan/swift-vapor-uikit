import Vapor
import Fluent
import FluentMongoDriver

// configures your application
public func configure(_ app: Application) throws
{
    // register database
    let db_userName = "YOUR_DB_USERNAME"
    let db_password = "YOUR_DB_PASSSWORD"
    let db_name     = "YOUR_DB_NAME"
    
    try app.databases.use(.mongo(connectionString: "mongodb+srv://\(db_userName):\(db_password)@\(db_name).mptwk.mongodb.net/myFirstDatabase?retryWrites=true&w=majority"), as: .mongo)

    app.migrations.add(CreateList())
    app.logger.logLevel = .debug
    
    try app.autoMigrate().wait()
    
    // register routes
    try routes(app)
}
