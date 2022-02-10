import Vapor

func routes(_ app: Application) throws {
    let listRoutesGroup = app.grouped("api", "v1", "list")
    let listController = ListController(service: ListService())
    
    listRoutesGroup.get("", use: listController.getAllLists(_:))
    listRoutesGroup.post("", use: listController.createList(_:))
    listRoutesGroup.get(":id", use: listController.getListById(_:))
    listRoutesGroup.put(":id", use: listController.updateListById(_:))
    listRoutesGroup.delete(":id", use: listController.deleteListById(_:))
}
