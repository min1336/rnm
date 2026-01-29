// Domain
export 'domain/entities/course.dart';
export 'domain/entities/running_context.dart';
export 'domain/entities/scored_course.dart';
export 'domain/entities/user_running_profile.dart';
export 'domain/repositories/course_repository.dart';
export 'domain/services/context_detector.dart';
export 'domain/services/course_scorer.dart';
export 'domain/services/recommendation_engine.dart';
export 'domain/usecases/get_recommended_courses.dart';

// Data
export 'data/datasources/course_remote_datasource.dart';
export 'data/models/course_model.dart';
export 'data/repositories/course_repository_impl.dart';

// Presentation
export 'presentation/providers/course_providers.dart';
export 'presentation/screens/course_list_screen.dart';
export 'presentation/widgets/context_confirm_dialog.dart';
export 'presentation/widgets/course_card.dart';
