import Vapor
import HTTP
import JSON

let drop = Droplet()

drop.get { _ -> ResponseRepresentable in
    return try JSON(node: ["key": "value"])
}

drop.run()
