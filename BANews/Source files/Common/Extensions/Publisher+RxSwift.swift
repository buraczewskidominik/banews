//
//  Publisher+RxSwift.swift
//  BANews
//
//  Created by Dominik Buraczewski on 23/11/2021.
//

import Foundation
import Combine

extension Publisher {
  /// If `Other` emits before `Self`, when `Self` emits it will emit a value of the latest from `Other`.
  /// This is unlike the behavior of RxSwift's withLatestFrom, where this scneario would end up not emitting any values.
  public func withLatestFrom<Other: Publisher, Result>(
    _ other: Other,
    resultSelector: @escaping (Output, Other.Output) -> Result
  ) -> AnyPublisher<Result, Failure> where Self.Failure == Other.Failure {
    Publishers.CombineLatest(map { ($0, arc4random()) }, other)
      .removeDuplicates(by: { $0.0.1 == $1.0.1 })
      .map { ($0.0, $1) }
      .map(resultSelector)
      .eraseToAnyPublisher()
  }

  public func withLatestFrom<Other: Publisher>(_ other: Other) -> AnyPublisher<Other.Output, Failure>
    where Self.Failure == Other.Failure
  {
    withLatestFrom(other) { $1 }
  }
}

