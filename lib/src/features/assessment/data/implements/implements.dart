import '../sources/assessmentdatasources.dart';
import '../../domain/repositories/repositories.dart';

class AssessmentRepositoryImp implements AssessmentRepository {
  final AssessmentDataSource remoteDataSource;
  AssessmentRepositoryImp({required this.remoteDataSource});

  // ... example ...
  //
  // Future<User> getUser(String userId) async {
  //     return remoteDataSource.getUser(userId);
  //   }
  // ...
}
