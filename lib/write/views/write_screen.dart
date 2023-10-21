import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_challenge/write/view_models/write_view_model.dart';

class WriteScreen extends ConsumerStatefulWidget {
  static const routeName = "write";
  static const routeURL = "/write";
  final void Function(int) onTapCallback;

  const WriteScreen({
    super.key,
    required this.onTapCallback,
  });

  @override
  WriteScreenState createState() => WriteScreenState();
}

class WriteScreenState extends ConsumerState<WriteScreen> {
  bool _isTextFilled = false;

  final TextEditingController _textEditingController = TextEditingController();

  final _protectSkills = [
    "\u{1F52E}",
    "\u{1F4BB}",
  ];

  final _protectSkillMeans = {
    "\u{1F601}": "마법",
    "\u{1F60A}": "양자컴퓨터",
  };

  int _isSelectIndex = 0;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isTextFilled = _textEditingController.text.isNotEmpty;
    });
  }

  void onNextPressed() async {
    await ref.read(writePostProvider.notifier).uploadPost(
          _textEditingController.text,
          _isSelectIndex,
        );

    widget.onTapCallback(0);
    _textEditingController.text = "";
    _isSelectIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 43,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              bottom: 8,
            ),
            child: ElevatedButton(
              onPressed: _isTextFilled ? onNextPressed : null,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text(
                "게시하기",
              ),
            ),
          ),
        ],
        elevation: 0.2,
        shadowColor: Colors.grey.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "글을 보호할 방어 기술을 선택하세요",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 20,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSelectIndex = index;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9 / 2,
                    height: 100,
                    decoration: _isSelectIndex == index
                        ? BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              width: 5,
                            ),
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                    child: Center(
                      child: Text(
                        _protectSkills[index],
                        style: const TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: 2,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: TextField(
                controller: _textEditingController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText:
                      "${_protectSkillMeans.values.toList()[_isSelectIndex]}을 선택하셨습니다\n추가로 AI가 알아볼 수 없는 방식으로 글을 작성하세요 \n옑륷듦녊 요롴켊 쓰셁욘",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
                cursorColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
