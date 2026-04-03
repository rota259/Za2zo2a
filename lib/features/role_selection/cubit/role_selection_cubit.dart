import 'package:flutter_bloc/flutter_bloc.dart';
import 'role_selection_state.dart';

class RoleSelectionCubit extends Cubit<RoleSelectionState> {
  RoleSelectionCubit() : super(const RoleSelectionState());

  void selectRole(UserRole role) {
    emit(state.copyWith(selectedRole: role));
  }
}
