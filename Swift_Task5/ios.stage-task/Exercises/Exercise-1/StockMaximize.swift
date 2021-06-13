import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        var profit = 0
        var purchased = [Int]()
        var slice = prices
        
        for day in prices.indices {
            if slice.contains(where: {$0 > prices[day]}) {
                purchased.append(prices[day])
            } else if !purchased.isEmpty {
                for share in purchased {
                    profit += (prices[day] - share)
                }
                slice.remove(at: slice.firstIndex(where: {$0 == prices[day]})!)
                purchased = []
            } else {
                slice.remove(at: slice.firstIndex(where: {$0 == prices[day]})!)
            }
        }
        return profit
    }
}
