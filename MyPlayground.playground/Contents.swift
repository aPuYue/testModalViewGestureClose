import UIKit
import Foundation

class Solution {
    func reverse(_ x: Int) -> Int {
        if (x > (pow(2, 21) - 1)) || (x < (pow(-2, 31))) {
            return 0
        }

        let arr = String(x).map {String($0)}
        if arr[0] == "-" {
            var brr = "-"
            for i in (1..<arr.count).reversed() {
                brr = brr + arr[i]
            }
            return Int(brr)!
        } else {
            var brr = ""
            for i in arr.reversed() {
                brr = brr + i
            }
            return Int(brr)!
        }
    }
}


reverse(123)
