import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
   
    var maxKilometers: Int {
        let drinkTab = knapSack(limit: maxWeight, w: drinksW , v: drinksV)
        let foodTab = knapSack(limit: maxWeight, w: foodW, v: foodV)
        return findMaxKilometres(foodLast: foodTab.last ?? [], drinkLast: drinkTab.last ?? [])
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func knapSack(limit: Int, w: [Int], v: [Int]) -> [[Int]] {
        let n = w.count
        var t = Array(repeating: Array(repeating: 0,count: limit+1), count: n+1)
        for i in 0...n {
            for j in 0...limit {
                if i == 0 || j == 0 {
                    t[i][j] = 0
                } else if w[i-1]<=j {
                    t[i][j] = max(v[i-1] + t[i-1][j-w[i-1]], t[i-1][j])
                } else {
                    t[i][j] = t[i-1][j]
                }
            }
        }
        return t
    }
    
    func findMaxKilometres(foodLast: [Int], drinkLast: [Int]) -> Int{
        var maxKM = 0
        for w in 0...maxWeight {
            
            var probable = foodLast[w]
            let drink = drinkLast[maxWeight-w]
            let food = foodLast[w]
            
            if drink < food {
                probable = drink
            }
            if probable > maxKM {
                maxKM = probable
            }
        }
        return maxKM
    }
}



extension Knapsack {
    var drinksW: [Int] {
        var arr = [Int]()
        drinks.forEach {arr += [$0.weight] }
        return arr
    }
    var drinksV: [Int] {
        var arr = [Int]()
        drinks.forEach {arr += [$0.value] }
        return arr
    }
    var foodW: [Int] {
        var arr = [Int]()
        foods.forEach {arr += [$0.weight] }
        return arr
    }
    var foodV: [Int] {
        var arr = [Int]()
        foods.forEach {arr += [$0.value] }
        return arr
    }
}

