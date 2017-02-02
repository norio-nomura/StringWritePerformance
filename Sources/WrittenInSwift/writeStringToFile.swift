import Foundation

public func write(value: String, handle: UnsafeMutablePointer<FILE>) throws {
    do {
        let units = Array(value.utf8)
        try units.withUnsafeBufferPointer({ (buffer: UnsafeBufferPointer<UTF8Char>) in

            let unitSize = MemoryLayout<UTF8Char>.size
            let unitCount = buffer.count

//            do {
//                try write(value: unitCount, handle: handle)
//            } catch {
//                throw error
//            }

            guard fwrite(buffer.baseAddress, unitSize, unitCount, handle) == unitCount else {
                throw NSError(domain: "com.sonson.2tch", code: 0, userInfo: ["message": "An error occurred during writing to the handle (errno: \(errno))"])
            }
        })
    } catch {
        throw error
    }
}

public func write2(value: String, handle: UnsafeMutablePointer<FILE>) throws {
    guard let data = value.data(using: .utf16LittleEndian),
        data.withUnsafeBytes({ fwrite($0, MemoryLayout<UInt8>.size, data.count, handle) }) == data.count
        else {
            throw NSError(domain: "com.sonson.2tch", code: 0, userInfo: ["message": "An error occurred during writing to the handle (errno: \(errno))"])
    }
}

public func write3(value: String, handle: UnsafeMutablePointer<FILE>) throws {
    let nsstring = value as NSString
    let count = nsstring.length
    let buffer = UnsafeMutablePointer<unichar>.allocate(capacity: count)
    defer { buffer.deallocate(capacity: count) }
    nsstring.getCharacters(buffer)
    guard fwrite(buffer, MemoryLayout<unichar>.size, count, handle) == count else {
        throw NSError(domain: "com.sonson.2tch", code: 0, userInfo: ["message": "An error occurred during writing to the handle (errno: \(errno))"])
    }
}
