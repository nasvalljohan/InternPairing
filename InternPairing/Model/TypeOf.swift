import Foundation

struct TypeOfDeveloper {
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
