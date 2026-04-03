import 'package:equatable/equatable.dart';

enum UserRole { driver, rider }

class RoleSelectionState extends Equatable {
  final UserRole selectedRole;

  const RoleSelectionState({this.selectedRole = UserRole.driver});

  RoleSelectionState copyWith({UserRole? selectedRole}) {
    return RoleSelectionState(selectedRole: selectedRole ?? this.selectedRole);
  }

  @override
  List<Object?> get props => [selectedRole];
}
