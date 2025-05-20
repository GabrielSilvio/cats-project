import Foundation

struct DateFormatterHelper {
    static func formatISO8601String(_ dateString: String, dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .none, locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = isoFormatter.date(from: dateString) else {
            return "Invalid date"
        }
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: date)
    }
} 