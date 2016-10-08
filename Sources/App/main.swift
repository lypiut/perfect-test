import Vapor
import HTTP
import JSON

let drop = Droplet()

guard let data = try? DataFile().load(path: drop.resourcesDir + "geojson/paris.geojson"),
    let string = try? String(bytes: data) , let protobuffer = try? Geojson(json: string),
    let jsonValue = try? protobuffer.serializeJSON(),
    let dataValue = try? protobuffer.serializeProtobufBytes() else {
        fatalError("Unable to decode protobuf data")
}

print(protobuffer.jsonFieldNames)


drop.get("/json") { (request) -> ResponseRepresentable in
    return jsonValue
}

drop.get("/proto") { (request) -> ResponseRepresentable in
   return Response(body: .data(dataValue))
}

drop.run()
