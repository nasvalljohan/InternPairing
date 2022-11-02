import Foundation

class DateFormatting: DateFormatter {
    var formatter = DateFormatter()
    
    func dateToString(dateOfBirth: Date) -> String {
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: dateOfBirth)
    }
    
    func ageConverter(string: String) -> String {
        let startDate = formatter.date(from: string)
        let endDate = Date()
        let calendar = Calendar.current
        let calcAge = calendar.dateComponents([.year], from: startDate!, to: endDate)
        let age = calcAge.year
        return "\(age ?? -1)"
    }
}
