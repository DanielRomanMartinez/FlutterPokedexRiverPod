import 'package:flutter/material.dart';
import 'package:flutter_pokedex/application/screens/user_information/user_information_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/domain/model/objects/user.dart';

class SearchPokemonField extends ConsumerStatefulWidget {
  final Function(String text) onChanged;
  final String placeHolder;

  const SearchPokemonField({
    required this.onChanged,
    required this.placeHolder,
    super.key,
  });

  @override
  ConsumerState<SearchPokemonField> createState() => _SearchPokemonFieldState();
}

class _SearchPokemonFieldState extends ConsumerState<SearchPokemonField> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userInformationNotifierProvider);

    final Color borderColor = userAsyncValue.when(
      data: (user) => user.backgroundColor,
      loading: () => User.defaultBackgroundColor,
      error: (_, __) => User.defaultBackgroundColor,
    );

    final Color cursorColor = userAsyncValue.when(
      data: (user) => user.backgroundColor,
      loading: () => User.defaultBackgroundColor,
      error: (_, __) => User.defaultBackgroundColor,
    );

    return TextField(
      controller: _textController,
      onChanged: (String text) => widget.onChanged.call(text),
      cursorColor: cursorColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.placeHolder,
        contentPadding: const EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: borderColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: borderColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
