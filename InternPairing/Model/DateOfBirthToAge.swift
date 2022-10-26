import Foundation

class DateManager: DateFormatter {
    
    func ageConverter(dateOfBirth: Date) {
        let now = Date.now
        
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    }
}
