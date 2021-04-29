import 'package:flutter/material.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

class RxTextField<T> extends StatelessWidget {
  // This form field subscribes to a stream
  final Stream<T>? subscribe;
  // This function dispatches values to manager
  final void Function(String) dispatch;
  var key;
  var controller;
  var focusNode;
  var decoration;
  var textInputAction;
  var textCapitalization;
  var style;
  var strutStyle;
  var textAlign;
  var textAlignVertical;
  var textDirection;
  var readOnly;
  var showCursor;
  var autofocus;
  var obscuringCharacter;
  var obscureText;
  var autocorrect;
  var enableSuggestions;
  var maxLines;
  var minLines;
  var expands;
  var maxLength;
  var maxLengthEnforced;
  var maxLengthEnforcement;
  var onChanged;
  var onEditingComplete;
  var onSubmitted;
  var onAppPrivateCommand;
  var inputFormatters;
  var enabled;
  var cursorWidth;
  var cursorHeight;
  var cursorRadius;
  var cursorColor;
  var selectionHeightStyle;
  var selectionWidthStyle;
  var keyboardAppearance;
  var scrollPadding;
  var enableInteractiveSelection;
  var selectionControls;
  var onTap;
  var mouseCursor;
  var buildCounter;
  var scrollController;
  var scrollPhysics;
  var autofillHints;
  var restorationId;

  RxTextField({
    this.subscribe,
    required this.dispatch,
    this.key,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    ToolbarOptions? toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    @Deprecated(
        'Use maxLengthEnforcement parameter which provides more specific '
            'behavior related to the maxLength limit. '
            'This feature was deprecated after v1.25.0-5.0.pre.'
    )
    this.maxLengthEnforced = true,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.restorationId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: subscribe,
      builder: (context, snapshot) {
        // Since decoration field is immutable constant we use elaborate assigning below
        InputDecoration decoration = this.decoration.copyWith(errorText: snapshot.error == null ? null : snapshot.error.toString(),
        );

        return TextField(
          // point free programming - construct functions where don't need to specify parameters
          onChanged: dispatch,
            key: key,
            controller: controller,
            focusNode: focusNode,
            decoration: decoration,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            style: style,
            strutStyle: strutStyle,
            textAlign: textAlign,
            textAlignVertical: textAlignVertical,
            textDirection: textDirection,
            readOnly: readOnly,
            showCursor: showCursor,
            autofocus: autofocus,
            obscuringCharacter: obscuringCharacter,
            obscureText: obscureText,
            autocorrect: autocorrect,
            enableSuggestions: enableSuggestions,
            maxLines: maxLines,
            minLines: minLines,
            expands: expands,
            maxLength: maxLength,
            maxLengthEnforced: maxLengthEnforced,
            maxLengthEnforcement: maxLengthEnforcement,
            onEditingComplete: onEditingComplete,
            onSubmitted: onSubmitted,
            onAppPrivateCommand: onAppPrivateCommand,
            inputFormatters: inputFormatters,
            enabled: enabled,
            cursorWidth: cursorWidth,
            cursorHeight: cursorHeight,
            cursorRadius: cursorRadius,
            cursorColor: cursorColor,
            selectionHeightStyle: selectionHeightStyle,
            selectionWidthStyle: selectionWidthStyle,
            keyboardAppearance: keyboardAppearance,
            scrollPadding: scrollPadding,
            enableInteractiveSelection: enableInteractiveSelection,
            selectionControls: selectionControls,
            onTap: onTap,
            mouseCursor: mouseCursor,
            buildCounter: buildCounter,
            scrollController: scrollController,
            scrollPhysics: scrollPhysics,
            autofillHints: autofillHints,
            restorationId: restorationId,
        );
      },
    );
  }
}
