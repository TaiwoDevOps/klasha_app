import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:klasha_app/core/error/exception.dart';
import 'package:klasha_app/core/error/failure.dart';
import 'package:klasha_app/core/managers/network_manager.dart';
import 'package:klasha_app/di/di.dart';

abstract class Repository {
  Repository({NetworkManager? networkNotifier})
      : _networkNotifier = networkNotifier ?? sl<NetworkManager>();
  final NetworkManager _networkNotifier;

  Future<bool> get hasNetwork => _networkNotifier.hasNetwork();

  @protected
  Future<Either<Failure, T>> runGuard<T>(
    Future<T> Function() call,
  ) async {
    if (await hasNetwork) {
      try {
        final result = await call();
        return Right(result);
      } catch (e, stack) {
        // Handle all exceptions here

        if (e is InvalidArgOrDataException) {
          return Left(InvalidArgOrDataFailure());
        }
        return Left(UnexpectedFailure());
      }
    }
    return Left(NetworkFailure());
  }
}
