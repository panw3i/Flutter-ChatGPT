import 'package:flutter/material.dart';
import 'package:frontend/gen/strings.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
/// 自定义聊天输入框[Message TextField]
///
class MessageTextField extends ConsumerStatefulWidget {
  const MessageTextField(this.controller, this.allowInput, this.handInput,
      {this.hintStr, this.maxWidth = 752, super.key});

  final TextEditingController controller;
  final bool allowInput;
  final String? hintStr;
  final double maxWidth;
  final Function(String) handInput;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MessageTextFieldState();
  }
}

class _MessageTextFieldState extends ConsumerState<MessageTextField> {
  bool _isFocused = false;
  late FocusNode _focusNode;

  //当前输出内容
  var _inputStr = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      constraints: BoxConstraints(minWidth: 360, maxWidth: widget.maxWidth),
      height: _isFocused ? 112 : 56,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(_isFocused ? 8 : 26),
        shadowColor: Theme.of(context).colorScheme.shadow,
        color: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Image.asset('assets/images/ic_chat.png',
                    width: 24, height: 24)),
            Expanded(
                child: TextField(
                    focusNode: _focusNode,
                    maxLines: null,
                    controller: widget.controller,
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    enabled: widget.allowInput,
                    onChanged: (str) => _inputStr = str,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hintStr ?? t.app.text_field_hint,
                        counter: const SizedBox(width: 0, height: 0),
                        isCollapsed: true,
                        hoverColor: const Color(0xFFCAC4D0),
                        contentPadding: const EdgeInsets.only(top: 18)))),
            Padding(
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: IconButton(
                    onPressed: () {
                      if (!widget.allowInput) return;
                      // handleInputStr(_inputStr, widget.conversationId);
                      widget.handInput(_inputStr);
                      widget.controller.clear();
                      _inputStr = '';
                    },
                    icon:
                        Icon(Icons.send, color: iconColor(widget.allowInput)))),
            // RawKeyboardListener(
            //     focusNode: _focusNode,
            //     onKey: (event) {
            //       if (event.logicalKey == LogicalKeyboardKey.enter ||
            //           event.logicalKey == LogicalKeyboardKey.numpadEnter) {
            //         // if (event.isShiftPressed) {
            //         //   //enter+shift 换行
            //         //   if (_inputStr.isEmpty) {
            //         //     showSnackBarTip('请输入内容');
            //         //     return;
            //         //   }
            //         //   _textController.value =
            //         //       TextEditingValue(text: '${_textController.text}\n');
            //         // } else {
            //         handleInputStr(_inputStr, conversationSelected);
            //         // }
            //       }
            //     },
            //     child: const SizedBox(width: 0, height: 0))
          ],
        ),
      ),
    );
  }

  Color iconColor(bool allowInput) {
    if (allowInput) {
      return Theme.of(context).colorScheme.secondary;
    }
    return Theme.of(context).colorScheme.outline;
  }
}
