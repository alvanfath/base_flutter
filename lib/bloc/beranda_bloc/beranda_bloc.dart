import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'beranda_event.dart';
part 'beranda_state.dart';

class BerandaBloc extends Bloc<BerandaEvent, BerandaState> {
  BerandaBloc() : super(BerandaInitial()) {
    on<BerandaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
