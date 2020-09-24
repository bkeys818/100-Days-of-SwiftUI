import Foundation

//private func unwrap<T>(_ optional: Optional<T>) -> T.Type {
//    if optional.conforms()
//    guard let unwapped = optional else {
//        switch T.self {
//        case is String.Type:
//            print("a")
//        case is Int16.Type:
//            print("b")
//        case is Date.Type:
//            print("c")
//        case [String]:
//            fatalError("String")
//        default:
//            return T.self
//        }
//        return T.self
//    }
////    return unwapped
//    return T.self
//}

func unwrap<T>(_ optional: T?) -> T {
    if let unwapped = optional {
        return unwapped
    }
    fatalError("Type \(type(of: optional)) is not an optional")
}

struct a {
    var name: String? = "Hello World"
}

let someClaass = a()
let value = unwrap(someClaass.name)
print(value, type(of: value))
