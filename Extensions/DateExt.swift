//
//  DateExt.swift
//  GHFollowers
//
//  Created by Jorge Fuentes Casillas on 23/07/21.
//

import Foundation


extension Date {
	
	func convertToMonthYearFormat() -> String {
		let dateFormatter 		 = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
				
		return dateFormatter.string(from: self)
	}
}
