import Foundation

extension String {
    func convertToInt() -> Int? {
        return Int(self)
    }
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Intentar con el formato completo (fecha + hora)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            return date
        }

        // Intentar con el formato solo de fecha
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
    func convertToURL() -> URL? {
        return URL(string: self)
    }
}
