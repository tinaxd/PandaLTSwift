//
//  PandaLTFetch.swift
//  PandaLTFetch
//
//  Created by tinaxd on 2020/10/05.
//

import Alamofire
import Foundation

public struct PandaLT {
    public static func getLoginTokenAsync(success: @escaping (String) -> Void, fail: @escaping () -> Void) {
        AF.request("https://cas.ecs.kyoto-u.ac.jp/cas/login").responseString {
            response in
            let regex = try! NSRegularExpression(pattern: "<input type=\"hidden\" name=\"lt\" value=\"(.+)\" \\/>");
            switch response.result {
            case .failure(_): fail();
            case let .success(str):
                guard let result = regex.firstMatch(in: str, options: [], range: NSRange(0..<str.count)) else {
                    fail();
                    return;
                }
                let start = result.range(at: 1).location;
                let end = start + result.range(at: 1).length;
                success(String(str[str.index(str.startIndex, offsetBy: start)..<str.index(str.startIndex, offsetBy: end)]));
            }
        }
    }
}
