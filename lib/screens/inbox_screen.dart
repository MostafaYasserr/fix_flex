import 'package:fix_flex/components/chat/chat_label.dart';
import 'package:fix_flex/cubits/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/get_my_chats_cubit/get_my_chats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InBoxScreen extends StatelessWidget {
  const InBoxScreen({super.key});

  static const String id = 'InBoxScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: BlocBuilder<GetMyChatsCubit, GetMyChatsState>(
        builder: (context, state) {
          if (state is GetMyChatsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetMyChatsFailure) {
            return const Center(
              child: Text('Failed to load chats'),
            );
          } else if (state is GetMyChatsSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: state.chatsHolders.length,
                itemBuilder: (context, index) {
                  return ChatLabel(
                    index: index,
                    chatId: state.myChatsDataModel[index].id,
                    image: state.chatsHolders[index].profilePicture?.url != null
                        ? NetworkImage(state.chatsHolders[index].profilePicture!.url as String) : null,

                    chatHolderName: '${state.chatsHolders[index].FirstName} ${state.chatsHolders[index].LastName}',
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
