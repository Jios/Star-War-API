import Foundation



extension Date
{
    var string: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter.string(from: self)
    }
}
