abstract class RecoveryPasswordEvent {
  const RecoveryPasswordEvent();
}

class RecoveryPasswordWithEmailEvent implements RecoveryPasswordEvent {
  final String email;

  const RecoveryPasswordWithEmailEvent({required this.email});
}
