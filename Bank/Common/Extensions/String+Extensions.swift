//
//  String+Extensions.swift
//  Bank
//
//  Created by RubyMaine on 09.08.2023.
//

public extension String {
    
    func maskCardNumber() -> String {
        guard self.count == "1111 1111 1111 1111".count else {
            return self
        }

        var newValue = ""
        let maxCount = self.count - 4
        
        self.enumerated().forEach { value in
            if 4 > value.offset || value.offset >= maxCount {
                // Displaying Text
                let string = String(value.element)
                newValue.append(contentsOf: string)
            } else {
                // Simply Displaying Star and Avoid Space
                let character = String(value.element)
                newValue.append(character == " " ? character : "*")
            }
        }
        return newValue
    }
}
