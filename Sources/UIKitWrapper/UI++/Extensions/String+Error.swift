//
//  String+Error.swift
//  CheqApp
//
//  Created by Овчар Денис on 20/09/2018.
//  Copyright © 2018 Овчар Денис. All rights reserved.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
