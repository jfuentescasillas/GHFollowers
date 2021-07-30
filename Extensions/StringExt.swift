//
//  StringExt.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 23/07/21.
//
// +++++ PUEDE SER ÚTIL PARA OTROS PROYECTOS +++++

import Foundation


extension String {
	/*
	func convertToDate() -> Date? {
		let dateFormatter 		 = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		dateFormatter.locale 	 = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone	 = .current
		
		return dateFormatter.date(from: self)
	}
	
	
	func convertToDisplayFormat() -> String {
		guard let date = self.convertToDate() else { return "N/A" }
		
		return date.convertToMonthYearFormat()
	}*/
	
	
	public var localized: String {
		return NSLocalizedString(self, comment: "")
	}
}
