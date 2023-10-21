import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_challenge/post/view_models/post_view_model.dart';
import 'package:twitter_clone_challenge/post/widgets/post_widget.dart';

class PostTimeLineScreen extends ConsumerStatefulWidget {
  const PostTimeLineScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PostTimeLineScreenState();
}

class PostTimeLineScreenState extends ConsumerState<PostTimeLineScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(postStreamProvider).when(
          data: (data) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => PostWidget(
                description: data[index].description,
                createdAt: data[index].createdAt,
                skillIndex: data[index].skillIndex,
                documentReference: data[index].documentReference,
              ),
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text("Could not load post: $error"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
