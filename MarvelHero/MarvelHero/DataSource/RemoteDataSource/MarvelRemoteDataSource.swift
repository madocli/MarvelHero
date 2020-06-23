//
//  MarvelRemoteDataSource.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 22/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import Foundation
import Alamofire


protocol MarvelRemoteDataSourceGateway {
    func getCharacterst(offset: Int, handler: @escaping (Result<CharacterResponseModel, HeroErrorModel>) -> Void)
}

class MarvelRemoteDataSource {
    func getParams() -> [String: Any] {
        var parameters = [String: Any]()
        parameters["ts"] = "1592611200"
        return parameters
    }
    
    func executeCodableRequest<T: Codable>(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, result: @escaping (Swift.Result<T, HeroErrorModel>) -> Void) {
        let request = AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseDecodable(of: T.self) { (dataResponse) in
            if let error = dataResponse.error {
                result(.failure(HeroErrorModel(message: error.localizedDescription)))
            }
            if let data = dataResponse.value {
                result(.success(data))
            }
        }
    }
}

extension MarvelRemoteDataSource: MarvelRemoteDataSourceGateway {
    func getCharacterst(offset: Int, handler: @escaping (Result<CharacterResponseModel, HeroErrorModel>) -> Void) {
        var parameters = getParams()
        parameters["offset"] = offset
        executeCodableRequest(url: "", method: .get, parameters: parameters, headers: nil, result: handler)
    }
}
