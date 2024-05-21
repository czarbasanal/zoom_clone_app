import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom/screens/add_contact_screen.dart';
import '../models/contact.dart';
import '../riverpod/providers.dart';
import 'chat_screen.dart';

class TeamChatScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final contactsStream = ref.watch(contactsStreamProvider);

    if (user == null) {
      print('No user logged in');
      return Center(child: Text('No user logged in'));
    } else {
      print('User ID found: ${user.id}');
    }

    return contactsStream.when(
      data: (_) {
        final contacts = ref.watch(contactsProvider);

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Team Chat',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            centerTitle: true,
            backgroundColor: const Color(0xFF37384C),
            actions: <Widget>[
              IconButton(
                icon: const Icon(CupertinoIcons.add,
                    color: Colors.white, size: 24),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                  child: CupertinoTextField(
                    placeholder: 'Search',
                    placeholderStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF6E6E6E),
                    ),
                    prefix: Padding(
                      padding: const EdgeInsets.fromLTRB(9.0, 6.0, 1.0, 6.0),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Color(0xFF6e7681),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFE0DEE8),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Container(
                  height: 120.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      CupertinoIconButton(
                          icon: CupertinoIcons.star_fill, label: 'Starred'),
                      CupertinoIconButton(
                          icon: CupertinoIcons.folder_fill, label: 'Folders'),
                      CupertinoIconButton(
                          icon: CupertinoIcons.at, label: 'Mentions'),
                      CupertinoIconButton(
                          icon: CupertinoIcons.arrow_up_right_square_fill,
                          label: 'Drafts & S...'),
                      CupertinoIconButton(
                          icon: CupertinoIcons.bookmark_fill,
                          label: 'Bookmarks'),
                      CupertinoIconButton(
                          icon: CupertinoIcons.news_solid, label: 'Files'),
                      CupertinoIconButton(
                          icon: CupertinoIcons.alarm_fill, label: 'Reminders'),
                      CupertinoIconButton(
                          icon: CupertinoIcons.person_add_solid,
                          label: 'Contact R...'),
                      CupertinoIconButton(
                          icon: CupertinoIcons.gear_solid, label: 'Customize'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          "Messages"),
                      IconButton(
                        onPressed: () => showCupertinoModalPopup(
                            context: context,
                            builder: createCupertinoActionSheet),
                        icon: Icon(CupertinoIcons.line_horizontal_3_decrease),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 300, // Adjust the height as needed
                  child: contacts.isEmpty
                      ? Center(child: Text('No contacts found'))
                      : ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return ListTile(
                              title: Text(contact.name),
                              subtitle: Text(contact.email),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatScreen(contact: contact),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Find People and start chatting!"),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: CupertinoButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.create,
                              color: CupertinoColors.white),
                          SizedBox(width: 10),
                          Text(
                            'Add Contacts',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.white,
                            ),
                          ),
                        ],
                      ),
                      color: CupertinoColors.activeBlue,
                      onPressed: () {
                        showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  title: Text("Add Contacts"),
                                  content: Column(
                                    children: <Widget>[
                                      SizedBox(height: 16),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddContactScreen()),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "By email address",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color:
                                                    CupertinoColors.activeBlue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: <CupertinoDialogAction>[
                                    CupertinoDialogAction(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ));
                      }),
                )
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          Center(child: Text('Error loading contacts')),
    );
  }

  Widget CupertinoIconButton({required IconData icon, required String label}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color(0xFFE0DEE8),
            ),
            child: Icon(
              icon,
              size: 35,
              color: Color(0xFF6e7681),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF6e7681),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

Widget createCupertinoActionSheet(BuildContext context) {
  return CupertinoActionSheet(
    actions: <CupertinoActionSheetAction>[
      CupertinoActionSheetAction(
        child: Text('Mentions'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      CupertinoActionSheetAction(
        child: Text('Direct messages'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      CupertinoActionSheetAction(
        child: Text('Unread'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      CupertinoActionSheetAction(
        child: Text('Muted'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
