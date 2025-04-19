import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_adv/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Auth state provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

// Auth state class
class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final User? user;

  AuthState({this.isLoading = false, this.errorMessage, this.user});

  AuthState copyWith({bool? isLoading, String? errorMessage, User? user}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      user: user ?? this.user,
    );
  }
}

// Auth notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthState()) {
    // Initialize with current user if available
    final currentUser = _authRepository.currentUser;
    if (currentUser != null) {
      state = state.copyWith(user: currentUser);
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _authRepository.signUp(email, password);

      if (response.user != null) {
        // Store additional user data if needed
        // await _supabase.from('profiles').insert({'id': response.user!.id, 'name': name});

        state = state.copyWith(isLoading: false, user: response.user);
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Please check your email to confirm your account',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _authRepository.signIn(email, password);

      if (response.user != null) {
        state = state.copyWith(isLoading: false, user: response.user);
      } else {
        state = state.copyWith(isLoading: false, errorMessage: 'Login failed');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);

    try {
      await _authRepository.signOut();
      state = AuthState(); // Reset state
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
