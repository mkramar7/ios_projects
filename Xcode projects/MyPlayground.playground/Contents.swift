import Foundation

let numbers = ["1", "2", "fish", "3"]

let evensMap = numbers.map(Int.init)

let evensCompactMap = numbers.compactMap(Int.init)

print(evensCompactMap)
