import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        guard message.count >= 1 && message.count <= 60 else { return "" }
        func descripting ( str: Substring) -> String? {
            var returned = "", words = "", num = "", doLoop = true, innerStr = str
            
            for i in str.indices {
                switch str[i] {
                case str[i] where str[i].isNumber:
                    guard doLoop else { continue }
                    num.append(str[i])
                case "[":
                    guard doLoop else { continue }
                    words.append(descripting(str: innerStr[innerStr.index(after: innerStr.openSquare!)...innerStr.index(before: innerStr.closeSquare!)]) ?? "")
                    guard !words.isEmpty else { return nil }
                    doLoop = false
                case "]":
                    if doLoop == false && i == innerStr.closeSquare! {
                        innerStr.removeFirst(innerStr.distance(from: innerStr.startIndex, to: innerStr.closeSquare!)+1)
                        doLoop = true
                    }
                    guard doLoop else { continue }
                    if !num.isEmpty && (Int(num)! > 300 || Int(num)! < 1) { return "" }
                    returned.append(String(repeating: words, count: Int(num) ?? 1))
                    num = ""; words = ""
                default:
                    guard doLoop else { continue }
                    num.isEmpty ? returned.append(str[i]) : words.append(str[i])
                }
            }
            return returned
        }
        return descripting(str: message.prefix(upTo: message.endIndex)) ?? ""
    }
}


extension Substring {
    
    var closeSquare:String.Index? {
        get {
            print(self)
            var countOpen = 0
            var countClose = 0
            for char in self.indices {
                if self[char] == "[" {
                    countOpen += 1
                } else if self[char] == "]" {
                    countClose += 1
                }
                if countClose == countOpen && (self[char] == "[" || self[char] == "]")  {
                    return char
                }
            }
            return nil
        }
    }
    
    var openSquare:String.Index? {
        get {
            for char in self.indices {
                if self[char] == "[" { return char }
            }
        return nil
        }
    }
}
