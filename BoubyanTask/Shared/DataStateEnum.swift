//
//  DataStateEnum.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 12/06/2022.
//

import Foundation

enum DataState {
    case loading
    case finished(Result)
        
    enum Result {
        case failure(Error)
        case success
    }
}
