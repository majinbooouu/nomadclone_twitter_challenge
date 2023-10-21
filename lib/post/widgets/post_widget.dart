import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone_challenge/post/repos/post_repo.dart';

final _protectSkills = [
  "\u{1F52E}",
  "\u{1F4BB}",
];

class PostWidget extends ConsumerStatefulWidget {
  final String description;
  final int createdAt;
  final int skillIndex;
  final DocumentReference? documentReference;

  const PostWidget({
    super.key,
    required this.description,
    required this.createdAt,
    required this.skillIndex,
    required this.documentReference,
  });

  @override
  createState() => _PostWidgetState();
}

class _PostWidgetState extends ConsumerState<PostWidget> {
  String calculateElapsedTime(int postTimestamp) {
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    final timeDifference = currentTimestamp - postTimestamp;

    if (timeDifference < 60000) {
      final seconds = (timeDifference / 1000).round();
      return '$seconds${seconds == 1 ? 's' : 's'}';
    } else if (timeDifference < 3600000) {
      final minutes = (timeDifference / 60000).round();
      return '$minutes${minutes == 1 ? 'm' : 'm'}';
    } else if (timeDifference < 86400000) {
      final hours = (timeDifference / 3600000).round();
      return '$hours${hours == 1 ? 'h' : 'h'}';
    } else {
      final days = (timeDifference / 86400000).round();
      return '$days${days == 1 ? 'd' : 'd'}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onLongPress: () {
          showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: const Text("Are you sure?"),
                    // content: const Text("Plx dont go"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "No",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      CupertinoDialogAction(
                        onPressed: () {
                          ref
                              .read(postRepo)
                              .deletePost(widget.documentReference!.id);

                          context.pop();
                          setState(() {});
                        },
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.skillIndex == 0 ? Colors.purple : Colors.cyan,
          ),
          child: ListTile(
            leading: Text(
              _protectSkills[widget.skillIndex],
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    calculateElapsedTime(widget.createdAt),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Text(widget.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
