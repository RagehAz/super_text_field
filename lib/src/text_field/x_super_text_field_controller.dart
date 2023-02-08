part of super_text_field;

class SuperTextFieldController {
  // -----------------------------------------------------------------------------

  const SuperTextFieldController();

  // --------------------------------------------------------------------------

  /// ALIGNMENT

  // --------------------
  /// TAMAM : WORKS PERFECT
  static TextAlign getTextAlignment({
    @required bool centered,
  }){

    if (centered == true){
      return TextAlign.center;
    }

    else {
      return TextAlign.start;
    }

  }
  // --------------------------------------------------------------------------

  /// KEYBOARD

  // --------------------
  /// TESTED : WORKS PERFECT
  static TextInputType getKeyboardType({
    @required TextInputAction textInputAction,
    @required TextInputType textInputType,
  }){
    final _textInputType = textInputAction == TextInputAction.newline ?
    TextInputType.multiline
        :
    textInputType;

    return _textInputType;
  }
  // --------------------------------------------------------------------------

  /// SIZING

  // --------------------
  ///
  static double getFieldHeight({
    @required BuildContext context,
    @required int minLines,
    @required double textHeight,
    @required bool withBottomMargin,
    @required bool withCounter,
    @required EdgeInsets textPadding,
  }){

    /// UNDER TEXT FIELD BOX MARGIN : THAT WE CAN NOT REMOVE
    final double _bottomMargin = withBottomMargin == true ? 7 : 0;

    final double _counterPaddingValue = withCounter ? 2.5 : 0;
    final double _counterHeight = withCounter ? textHeight * counterTextHeightFactor : 0;

    final double _totalCounterBoxHeight = _counterHeight + (2 * _counterPaddingValue);

    final double _concludedHeight = (textPadding?.top ?? 0 + textPadding?.bottom ?? 0)
                                  + (minLines * textHeight)
                                  + _bottomMargin
                                  + _totalCounterBoxHeight;

    return _concludedHeight;
  }
  // --------------------------------------------------------------------------

  /// STYLING

  // --------------------
  /// TESTED : WORKS PERFECT
  static TextStyle createHintStyle({
    @required double textHeight,
    @required bool textItalic,
    @required String font,
  }) {

    return createTextStyle(
      color: const Color.fromARGB(80, 255, 255, 255),
      italic: textItalic,
      textHeight: textHeight * 0.8,
      fontFamily: font,
    );

  }
    // --------------------
  /// TESTED : WORKS PERFECT
  static TextStyle createErrorStyle({
    @required double textHeight,
    @required bool textItalic,
    @required String font,
    Color errorTextColor,
  }){

    return createTextStyle(
      color: errorTextColor ?? const Color.fromARGB(255, 233, 0, 0),
      // fontWeight: FontWeight.w100,
      textHeight: textHeight * 0.95,
      italic: true,
      fontFamily: font,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static OutlineInputBorder createOutlineBorder({
    @required Color borderColor,
    @required double corners,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(corners),
      borderSide: BorderSide(
        color: borderColor,
        width: 0.5,
      ),
      gapPadding: 0,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static InputDecoration createDecoration({
    @required double textHeight,
    @required String hintText,
    @required bool textItalic,
    @required double corners,
    @required Color fieldColor,
    @required bool counterIsOn,
    @required Color errorTextColor,
    @required EdgeInsets textPadding,
    @required Color focusedBorderColor,
    @required Color enabledBorderColor,
    @required Color focusedErrorBorderColor,
    @required Color errorBorderColor,
    @required String font,
  }){

    final InputDecoration _inputDecoration = InputDecoration(
      hintText: hintText,
      hintMaxLines: 1,
      hintStyle: createHintStyle(
        textHeight: textHeight,
        textItalic: textItalic,
        font: font,
      ),
      alignLabelWithHint: true,
      contentPadding: textPadding ?? const EdgeInsets.all(10),

      focusedBorder: createOutlineBorder(
        borderColor: focusedBorderColor,
        corners: corners,
      ),
      enabledBorder: createOutlineBorder(
        borderColor: enabledBorderColor,
        corners: corners,
      ),

      errorStyle: createErrorStyle(
        textItalic: textItalic,
        textHeight: textHeight,
        errorTextColor: errorTextColor,
        font: font,
      ),
      errorMaxLines: 3,
      // errorText: 'initial state error text',

      focusedErrorBorder: createOutlineBorder(
        borderColor: focusedErrorBorderColor,
        corners: corners,
      ),

      errorBorder: createOutlineBorder(
        borderColor: errorBorderColor,
        corners: corners,
      ),
      border: createOutlineBorder(
          borderColor: enabledBorderColor,
          corners: corners
      ),
      disabledBorder: createOutlineBorder(
        borderColor: const Color.fromARGB(255, 200, 200, 200),
        corners: corners,
      ),

      counter: counterIsOn == true ? null : const Offstage(),
      // counterText: 'a77aaaa ',

      // counterText: '${widget.textController?.text?.length} / ${widget.maxLength}',
      // counterStyle: superTextStyle(Colorz.white200, 0.7),

      // SOME BULLSHIT
      isDense: true,
      // isCollapsed: false,
      // semanticCounterText: 'semantic',
      focusColor: const Color.fromARGB(255, 24, 157, 14),
      filled: true,
      fillColor: fieldColor,

      // helperText: 'helper',
      // errorText: 'there is some error here',
      // icon: WebsafeSvg.asset(Iconz.DvRageh, height: 20),
    );

    return _inputDecoration;
  }
  // --------------------------------------------------------------------------

  /// COUNTER

  // --------------------
  static const double counterTextHeightFactor = 0.8;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Widget textFieldCounter({
    @required int currentLength,
    @required int maxLength,
    @required double textHeight,
    @required Color fieldColor,
  }){
    return SuperText(
      text: '$currentLength / $maxLength',
      weight: FontWeight.w100,
      textHeight: textHeight * counterTextHeightFactor,
      // size: 2,
      // scaleFactor: 1,
      boxColor: currentLength > maxLength ? const Color.fromARGB(125, 233, 0, 0) : fieldColor,
    );

  }
  // --------------------------------------------------------------------------

  /// SCROLL PADDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets adaptiveScrollPadding({
    @required BuildContext context,
  }){

    final EdgeInsets _scrollPadding = EdgeInsets.only(
      bottom: 100 + MediaQuery.of(context).viewInsets.bottom,
      top: 100 + MediaQuery.of(context).viewInsets.top,
    );

    return _scrollPadding;
  }
  // -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
  static void setNotifier({
    @required ValueNotifier<dynamic> notifier,
    @required bool mounted,
    @required dynamic value,
    bool addPostFrameCallBack = false,
    Function onFinish,
    bool shouldHaveListeners = false,
  }){

  if (mounted == true){
    // blog('setNotifier : setting to ${value.toString()}');

    if (notifier != null){

      if (value != notifier.value){

        /// ignore: invalid_use_of_protected_member
        if (shouldHaveListeners == false || notifier.hasListeners == true){

          if (addPostFrameCallBack == true){
            WidgetsBinding.instance.addPostFrameCallback((_){
              notifier.value  = value;
              if(onFinish != null){
                onFinish();
              }
            });
          }

          else {
            notifier.value  = value;
            if(onFinish != null){
              onFinish();
            }
          }

        }

      }

    }

  }

}
  // -----------------------------------------------------------------------------

  /// VALIDATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String bakeValidator({
    @required String Function(String text) validator,
    @required String text,
    bool keepEmbeddedBubbleColor = false,
  }){

    if (validator == null){
      return null;
    }

    else {

      if (keepEmbeddedBubbleColor == true){
        return validator(text);
      }

      else {
        return _bakeValidatorMessage(validator(text));
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _bakeValidatorMessage(String message){
    String _output;

    if (message != null){
      _output = TextMod.removeTextBeforeFirstSpecialCharacter(message, 'Δ');
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  void f(){}
}
