part of super_text_field;

class SuperTextField extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SuperTextField({
    @required this.width,
    this.globalKey,
    this.textController,

    /// main
    this.isFormField,
    this.initialValue,
    this.hintText = '...',
    this.autofocus = false,
    this.focusNode,
    this.counterIsOn = false,
    this.autoValidate = true,

    /// box
    this.margins,
    this.corners = 12,
    this.fieldColor = const Color.fromARGB(100, 255, 255, 255),

    /// text
    this.textDirection,
    this.centered = false,
    this.maxLines = 7,
    this.minLines = 1,
    this.maxLength = 50,
    this.scrollController,

    /// keyboard
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,

    /// styling
    this.textWeight = FontWeight.w200,
    this.textColor = const Color.fromARGB(1000, 255, 255, 255),
    this.textItalic = false,
    this.textHeight = 25,
    this.textShadows,
    this.package,
    this.cursorColor = const Color.fromARGB(1000, 255, 255, 255),
    this.letterSpacing,
    this.wordSpacing,
    this.scrollPadding,
    this.textFont,

    /// functions
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onSavedForForm,
    this.onEditingComplete,
    this.validator,

    this.isObscured,
    this.appIsLTR = true,

    this.textPadding,
    this.errorTextColor = const Color.fromARGB(125, 233, 0, 0),
    this.enabledBorderColor = const Color.fromARGB(255, 255, 255, 255),
    this.focusedBorderColor = const Color.fromARGB(255, 255, 255, 255),
    this.errorBorderColor = const Color.fromARGB(125, 233, 0, 0),
    this.focusedErrorBorderColor = const Color.fromARGB(125, 233, 0, 0),

    Key key,
  }) : super(key: key);
  // --------------------------------------------------------------------------
  /// main
  final bool isFormField;
  final TextEditingController textController;
  final String initialValue;
  final String hintText;
  final bool autofocus;
  final FocusNode focusNode;
  final bool counterIsOn;
  final bool autoValidate;

  /// box
  final double width;
  final dynamic margins;
  final dynamic corners;
  final Color fieldColor;

  /// keyboard
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  /// text
  final TextDirection textDirection;
  final bool centered;
  final int maxLines;
  final int minLines;
  final int maxLength;
  final ScrollController scrollController;

  /// styling
  final FontWeight textWeight;
  final Color textColor;
  final bool textItalic;
  final double textHeight;
  final List<Shadow> textShadows;
  final String package;
  final Color cursorColor;
  final double letterSpacing;
  final double wordSpacing;
  final EdgeInsets scrollPadding;
  final String textFont;

  /// functions
  final Function onTap;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onSavedForForm;
  final Function onEditingComplete;
  // final ValueChanged<String> onPaste;
  /// should return error string or null if there is no error
  final String Function(String) validator;

  final ValueNotifier<bool> isObscured;
  final GlobalKey globalKey;
  final bool appIsLTR;

  final Color errorTextColor;
  final EdgeInsets textPadding;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;

  /// --------------------------------------------------------------------------
  @override
  _SuperTextFieldState createState() => _SuperTextFieldState();
  /// --------------------------------------------------------------------------
}

class _SuperTextFieldState extends State<SuperTextField> {
  // -----------------------------------------------------------------------------
  TextEditingController _controller;
  FocusNode _focusNode;
  final ValueNotifier<TextDirection> _textDirection = ValueNotifier(null);
  ScrollController _scrollController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _controller = widget.textController ?? TextEditingController(text: widget.initialValue ?? '',);

    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus == true){
        if (widget.globalKey != null){
          final RenderObject object = widget.globalKey.currentContext?.findRenderObject();
          object?.showOnScreen();
        }
      }
    });

    _scrollController = widget.scrollController ?? ScrollController();

    SuperTextFieldController.setNotifier(
        notifier: _textDirection,
        mounted: mounted,
        value: TextDir.autoSwitchTextDirection(
          val: widget.textController?.text,
          context: context,
          appIsLTR: widget.appIsLTR,
        ),
    );

  }
  // --------------------
  @override
  void didUpdateWidget(covariant SuperTextField oldWidget) {

    if (oldWidget.initialValue != widget.initialValue){

      /// KEEPS REBUILDING THE ENTIRE WIDGET WITH EACH KEYBOARD ENTRY AND FUCKS UP MEMORY
      // WidgetsBinding.instance.addPostFrameCallback((_){
      //
      //   _controller.text = widget.initialValue;
      //   _controller.selection = TextSelection.fromPosition(
      //     TextPosition(offset: (_controller.text ?? '').length),
      //   );
      //
      // });

    }

    super.didUpdateWidget(oldWidget);
  }
  // --------------------
  @override
  void dispose(){

    if (widget.textController == null){
      _controller.dispose();
    }

    if (widget.scrollController == null){
      _scrollController.dispose();
    }

    if (widget.focusNode == null){
      _focusNode.dispose();
    }

    _textDirection.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _onTextChanged(String val) {

    if (val != null) {
      SuperTextFieldController.setNotifier(
        notifier: _textDirection,
        mounted: mounted,
        value: TextDir.autoSwitchTextDirection(
          val: val,
          context: context,
          appIsLTR: widget.appIsLTR,
        ),
      );

      if (widget.onChanged != null) {
        widget.onChanged(val);
      }
    }

  }
  // --------------------
  Widget _getTextField({
    @required bool isObscured,
    @required TextDirection textDirection,
  }){

    return TextFormFieldSwitcher(
      /// main
      isFormField: widget.isFormField,
      controller: _controller,
      hintText: widget.hintText,
      autoFocus: widget.autofocus,
      focusNode: _focusNode,
      counterIsOn: widget.counterIsOn,
      autoValidate: widget.autoValidate,
      /// box
      corners: widget.corners,
      /// keyboard
      textInputAction: widget.textInputAction,
      textInputType: widget.textInputType,
      /// text
      textDirection: textDirection,
      obscured: isObscured,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      scrollController: _scrollController,
      /// styling
      centered: widget.centered,
      textShadows: widget.textShadows,
      fontWeight: widget.textWeight,
      textHeight: widget.textHeight,
      letterSpacing: widget.letterSpacing,
      textFont: widget.textFont,
      wordSpacing: widget.wordSpacing,
      scrollPadding: widget.scrollPadding,
      textItalic: widget.textItalic,
      textColor: widget.textColor,
      fieldColor: widget.fieldColor,
      package: widget.package,
      cursorColor: widget.cursorColor,
      /// functions
      onTap: widget.onTap,
      onChanged: _onTextChanged,
      onSubmitted: widget.onSubmitted,
      onSavedForForm: widget.onSavedForForm,
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,

      enabledBorderColor: widget.enabledBorderColor,
      errorBorderColor: widget.errorBorderColor,
      errorTextColor: widget.errorTextColor,
      focusedBorderColor: widget.focusedBorderColor,
      focusedErrorBorderColor: widget.focusedErrorBorderColor,
      textPadding: widget.textPadding,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperTextFieldBox(
      key: const ValueKey<String>('The_super_text_field'),
      width: widget.width,
      height: SuperTextFieldController.getFieldHeight(
        context: context,
        minLines: widget.minLines,
        textHeight: widget.textHeight,
        textPadding: widget.textPadding,
        withCounter: widget.counterIsOn,
        withBottomMargin: false,
      ),
      margins: widget.margins,
      corners: widget.corners,
      child: ValueListenableBuilder(
          valueListenable: _textDirection,
          builder: (_, TextDirection textDirection, Widget child){

            final TextDirection _concludedTextDirection = TextDir.concludeTextDirection(
              context: context,
              definedDirection: widget.textDirection,
              detectedDirection: textDirection,
              appIsLTR: widget.appIsLTR,
            );

            /// CAN OBSCURE
            if (widget.isObscured != null){
              return ValueListenableBuilder(
                valueListenable: widget.isObscured,
                builder: (_, bool _isObscured, Widget child){

                  return _getTextField(
                    textDirection: _concludedTextDirection,
                    isObscured: _isObscured,
                  );

                  },
              );
            }

            /// CAN NOT OBSCURE
            else {
              return _getTextField(
                textDirection: _concludedTextDirection,
                isObscured: false,
              );
            }

          }),
    );

  }
  // -----------------------------------------------------------------------------
}
