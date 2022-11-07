import Foundation

class Formatter: DateFormatter {
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
    
    func typeOfDev(int: Int) -> String {
        var str = ""
        //TODO: Maybe add case for web-dev?
        switch int {
        case 1:
            str = "Android Developer"
            break
        case 2:
            str = "iOS Developer"
            break
        case 3:
            str = "Hybrid Developer"
            break
        default:
            str = "Not specified"
            break
        }
        
        return str
    }
}
