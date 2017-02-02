import PackageDescription

let package = Package(
    name: "StringWritePerformance",
    targets: [
        Target(name: "StringWritePerformance", dependencies: ["WrittenInObjC", "WrittenInSwift"]),
        Target(name: "WrittenInObjC"),
        Target(name: "WrittenInSwift")
    ]
)
