import Foundation

class FuncManager: NSObject{
    static let shared = FuncManager()
    private override init() {}
    
    
    var memoryCell:Double = 0
    
    
    func add(_ x: Double, _ y: Double) -> Double{
        return x+y
    }
    func substract(_ x: Double, _ y: Double) -> Double{
        return x-y
    }
    func multiply(_ x: Double, _ y: Double) -> Double{
        return x*y
    }
    func divide(_ x: Double, _ y: Double) -> Double{
        return x/y
    }
    func powIt(_ x: Double, _ y: Double) -> Double{
        return pow(x, y)
    }
    func squareRoot(_ x: Double) -> Double{
        return sqrt(x)
    }
    func factorial(_ x: Double) -> Double{
        if x == 0{
            return 1
        }
        return x * factorial(x-1)
    }
    func reverseNumber(_ x: Double) -> Double{
        return 1/x
    }
    func logarithm(_ x: Double) -> Double{
        return log10(x)
    }
    func naturalLogarithm(_ x: Double) -> Double{
        return log(x)
    }
    
    func mSave(_ x: Double){
        self.memoryCell = x
    }
    func mRead() -> Double{
        return self.memoryCell
    }
    func mPlus(_ x: Double){
        self.memoryCell = self.memoryCell+x
    }
    func mMinus(_ x: Double){
        self.memoryCell = self.memoryCell-x
    }
    func mClear(){
        self.memoryCell = 0.0
    }
    
}
