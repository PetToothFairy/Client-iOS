//
//  Network.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/27.
//

import Foundation
import UIKit

class NetworkManager {
  static let shared = NetworkManager()
  
  private init() {}
  
  private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    let scaleFactor = min(widthRatio, heightRatio)
    
    let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
    image.draw(in: CGRect(origin: .zero, size: newSize))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resizedImage!
  }
  
  func postTartarImage(image: UIImage, completion: @escaping (Result<Data, Error>) -> Void) {
    let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 300, height: 180)) // 원하는 크기로 조정
    
    let imageData = resizedImage.jpegData(compressionQuality: 1)
    let fileContent = imageData?.base64EncodedString()
    let postData = fileContent!.data(using: .utf8)
    
    var request = URLRequest(url: URL(string: "https://detect.roboflow.com/dog-dental/4?api_key=gKGwmx5kytR3rm5SFxHt&name=YOUR_IMAGE.jpg")!, timeoutInterval: Double.infinity)
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = postData
    
    URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
      print("👉통신 시작===================")
      guard let data = data else {
        print(String(describing: error))
        completion(.failure(error!))
        return
      }
      
      do {
        let _ = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
      } catch {
        print(error.localizedDescription)
      }
      
      print(String(data: data, encoding: .utf8)!)
      completion(.success(data))
    }).resume()
  }
  
  // 네트워크 에러 정의
  enum NetworkError: Error {
    case invalidURL
    case imageEncodingFailed
    case serverError
    case noData
    case decodingFailed
  }
}
