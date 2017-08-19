//
//  Semver.swift
//  HealthUploader
//
//  Created by Kevin Dayton on 8/5/17.
//  Copyright © 2017 Volatile Eight Industries. All rights reserved.
//

import Foundation

struct Semver: Equatable {
  var value : String
  
  init() {
    self.value = "0.0.0"
  }
  
  init(_ value : String) {
    switch value.characters.split(separator: ".").count {
    case 2:
      self.value = value + ".0"
    case 1:
      self.value = value + ".0.0"
    default:
      self.value = value
    }
  }
  
  static func compare(_ lhs : Semver, _ rhs : Semver) -> Int {
    var ret = 0
    let lhsParts = lhs.value.characters.split(separator: ".").map(String.init).map({ return Int($0)!})
    let rhsParts = rhs.value.characters.split(separator: ".").map(String.init).map({ return Int($0)!})
    switch (lhsParts,rhsParts) {
    case let (x, y) where x[0] > y[0] :
      ret = 1
      break
    case let (x, y) where x[0] < y[0] :
      ret = -1
      break
    case let (x, y) where x[1] > y[1] :
      ret = 1
      break
    case let (x, y) where x[1] < y[1] :
      ret = -1
      break
    case let (x, y) where x[2] > y[2] :
      ret = 1
      break
    case let (x, y) where x[2] < y[2] :
      ret = -1
      break
    default:
      ret = 0
    }
    
    return ret
  }
}

/**
 * Custom Operators
 */

func >(_ lhs : Semver, _ rhs : Semver) -> Bool {
  var ret = false
  switch (lhs,rhs) {
  case let (x, y) where Semver.compare(x, y) == 0  :
    ret = false
    break
  case let (x, y) where Semver.compare(x, y) == -1  :
    ret = false
    break
  default:
    ret = true
  }
  
  return ret
}

func <(_ lhs : Semver, _ rhs : Semver) -> Bool {
  var ret = false
  switch (lhs,rhs) {
  case let (x, y) where Semver.compare(x, y) == 0  :
    ret = false
    break
  case let (x, y) where Semver.compare(x, y) == 1  :
    ret = false
    break
  default:
    ret = true
  }
  
  return ret
}

func ==(_ lhs : Semver, _ rhs : Semver) -> Bool {
  var ret = false
  switch (lhs,rhs) {
  case let (x, y) where Semver.compare(x, y) == -1  :
    ret = false
    break
  case let (x, y) where Semver.compare(x, y) == 1  :
    ret = false
    break
  default:
    ret = true
  }
  
  return ret
}

func >=(_ lhs : Semver, _ rhs : Semver) -> Bool {
  var ret = false
  switch (lhs,rhs) {
  case let (x, y) where Semver.compare(x, y) == -1  :
    ret = false
    break
  case let (x, y) where Semver.compare(x, y) == 1  :
    ret = true
    break
  default:
    ret = true
  }
  
  return ret
}

func <=(_ lhs : Semver, _ rhs : Semver) -> Bool {
  var ret = false
  switch (lhs,rhs) {
  case let (x, y) where Semver.compare(x, y) == -1  :
    ret = true
    break
  case let (x, y) where Semver.compare(x, y) == 1  :
    ret = false
    break
  default:
    ret = true
  }
  
  return ret
}

func !=(_ lhs : Semver, _ rhs : Semver) -> Bool {
  var ret = true
  switch (lhs,rhs) {
  case let (x, y) where Semver.compare(x, y) == -1  :
    ret = true
    break
  case let (x, y) where Semver.compare(x, y) == 1  :
    ret = true
    break
  default:
    ret = false
  }
  
  return ret
}
