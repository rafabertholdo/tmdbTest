//
//  ApiError.swift
//  tmdbTest
//
//  Created by Rafael Guilherme Bertholdo on 26/10/18.
//  Copyright © 2018 Rafael Guilherme Bertholdo. All rights reserved.
//

import UIKit

/// API access errors
///
/// - invalidParams: Invalid parameters passed to the API
/// - failure: General failure
/// - invalidReponse: API response invalid
/// - connectionFailure: Connection failure
/// - emptyResponse: Empty server resonse
/// - clientOrServerError: Reponse not on 200..299 range
public enum ApiError: Error {
    case invalidParams(String?)
    case failure(Error, statusCode: Int)
    case invalidReponse(statusCode: Int)
    case connectionFailure
    case emptyResponse
    case clientOrServerError(statusCode: Int, data: Data)
}
