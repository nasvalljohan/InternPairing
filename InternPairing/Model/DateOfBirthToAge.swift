import Foundation

class DateOfBirthToAge: DateFormatter {
    var formatter = DateFormatter()
    
    func dateToString(dateOfBirth: Date) -> String {
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: dateOfBirth)
    }
    
    func ageConverter(string: String) {
        let startDate = formatter.date(from: string)
        let endDate = Date()

        let calendar = Calendar.current
        let calcAge = calendar.dateComponents([.year], from: startDate!, to: endDate)
        let age = calcAge.year
        print(age ?? 0)
    }
}