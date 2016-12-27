
import Foundation

extension Range
{
    var randomInt: Int
        {
        get
        {
            var offset = 0
            
            if (lowerBound as! Int) < 0   // allow negative ranges
            {
                offset = abs(lowerBound as! Int)
            }
            
            let mini = UInt32(lowerBound as! Int + offset)
            let maxi = UInt32(upperBound as! Int + offset)
            
            return Int(mini + arc4random_uniform(maxi - mini)) - offset
        }
    }
}
